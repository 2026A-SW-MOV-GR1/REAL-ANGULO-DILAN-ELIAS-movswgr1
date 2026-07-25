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
      title: 'Workshop Inter-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
  // Estado para Intents Entrantes
  late StreamSubscription _intentSub;
  String? _sharedText;
  String? _sharedImagePath;

  // Estado para Intents Salientes
  final TextEditingController _phoneController = TextEditingController(text: "0987654321");
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Escuchar intents mientras la app está en memoria
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      _handleSharedMedia(value);
    }, onError: (err) {
      debugPrint("Error en stream de compartición: $err");
    });

    // Manejar el intent que abrió la app desde cero
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      _handleSharedMedia(value);
    });
  }

  void _handleSharedMedia(List<SharedMediaFile> value) {
    if (value.isNotEmpty) {
      setState(() {
        if (value.first.type == SharedMediaType.text || value.first.type == SharedMediaType.url) {
          _sharedText = value.first.path;
          _sharedImagePath = null;
        } else {
          _sharedImagePath = value.first.path;
          _sharedText = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _intentSub.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  // Lógica: Iniciar Marcador (ACTION_DIAL)
  Future<void> _makeCall() async {
    final Uri url = Uri(scheme: 'tel', path: _phoneController.text);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showSnackBar('No se pudo abrir el marcador');
    }
  }

  // Lógica: Capturar Imagen (ACTION_IMAGE_CAPTURE)
  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImage = File(photo.path);
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
              Tab(icon: Icon(Icons.send), text: 'Salientes'),
              Tab(icon: Icon(Icons.download), text: 'Entrantes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOutgoingTab(),
            _buildIncomingTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOutgoingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Intents Salientes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          const SizedBox(height: 10),
          // Acción: Dial
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Número telefónico',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _makeCall,
            icon: const Icon(Icons.dialpad),
            label: const Text('ABRIR MARCADOR'),
          ),
          const SizedBox(height: 30),
          // Acción: Cámara
          const Text('Captura de Imagen', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _capturedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.file(_capturedImage!, fit: BoxFit.cover),
                  )
                : const Center(child: Text('Sin imagen capturada')),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _takePhoto,
            icon: const Icon(Icons.camera_alt),
            label: const Text('TOMAR FOTO'),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Intents Entrantes (Shared)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            _sharedText == null && _sharedImagePath == null
                ? 'Esperando contenido externo...'
                : '¡Contenido Recibido!',
            style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Texto compartido
          ListTile(
            title: const Text('Texto/URL recibida:'),
            subtitle: Text(_sharedText ?? 'Ninguno'),
            tileColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          const SizedBox(height: 20),
          // Imagen compartida
          const Text('Imagen recibida:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _sharedImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.file(File(_sharedImagePath!), fit: BoxFit.contain),
                  )
                : const Center(child: Text('Ninguna imagen compartida')),
          ),
        ],
      ),
    );
  }
}
