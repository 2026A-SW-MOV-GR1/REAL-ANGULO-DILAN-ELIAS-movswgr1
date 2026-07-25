import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inter-App Communication',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Shared data state
  late StreamSubscription _intentDataStreamSubscription;
  String? _sharedText;
  String? _sharedImagePath;

  // Outgoing actions state
  final TextEditingController _phoneController =
      TextEditingController(text: "0987654321");
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // For sharing images or text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      setState(() {
        if (value.isNotEmpty) {
          if (value.first.type == SharedMediaType.text ||
              value.first.type == SharedMediaType.url) {
            _sharedText = value.first.path;
            _sharedImagePath = null;
          } else {
            _sharedImagePath = value.first.path;
            _sharedText = null;
          }
        }
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images or text coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          if (value.first.type == SharedMediaType.text ||
              value.first.type == SharedMediaType.url) {
            _sharedText = value.first.path;
            _sharedImagePath = null;
          } else {
            _sharedImagePath = value.first.path;
            _sharedText = null;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _makeCall() async {
    final String phoneNumber = _phoneController.text;
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo iniciar el marcador')),
      );
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImage = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comunicación Inter-App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.outbound), text: 'Salientes'),
              Tab(icon: Icon(Icons.move_to_inbox), text: 'Entrantes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOutgoingPanel(),
            _buildIncomingPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildOutgoingPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'MÓDULO: INTENTS SALIENTES',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Panel 1: Dial
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _makeCall,
                child: const Text('INICIAR DIAL'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Panel 2: Camera
          Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _capturedImage != null
                    ? Image.file(_capturedImage!, fit: BoxFit.cover)
                    : const Center(child: Text('[Miniatura]')),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('TOMAR FOTO'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'MÓDULO: INTENTS ENTRANTES',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _sharedText == null && _sharedImagePath == null
                ? 'Estado: Esperando datos externos...'
                : 'Estado: ¡Dato Recibido!',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          // Text Case
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _sharedText ?? 'Ningún texto compartido todavía.',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
          // Image Case
          const Text('Imagen Recibida:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _sharedImagePath != null
                ? Image.file(File(_sharedImagePath!), fit: BoxFit.contain)
                : const Center(
                    child: Text('Contenedor Dinámico para Imagen Recibida'),
                  ),
          ),
        ],
      ),
    );
  }
}
