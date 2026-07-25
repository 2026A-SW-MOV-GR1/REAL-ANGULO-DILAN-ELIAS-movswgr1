import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/shelter_match_case.dart';
import 'services/intent_service.dart';

void main() {
  runApp(const ReencuentroApp());
}

class ReencuentroApp extends StatelessWidget {
  const ReencuentroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reencuentro PetFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShelterMatchCase? activeCase;
  StreamSubscription? _intentSubscription;

  @override
  void initState() {
    super.initState();
    _checkInitialIntent();
    _listenToNewIntents();
  }

  @override
  void dispose() {
    _intentSubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkInitialIntent() async {
    final receivedCase = await IntentService.getInitialCase();
    if (receivedCase != null) setState(() => activeCase = receivedCase);
  }

  void _listenToNewIntents() {
    _intentSubscription = IntentService.onNewCase.listen((receivedCase) {
      setState(() => activeCase = receivedCase);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Caso de ${receivedCase.petName} recibido!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 4: Reencuentro (Unificada)'),
        backgroundColor: Colors.green.shade100,
        centerTitle: true,
      ),
      body: Center(
        child: activeCase == null
            ? _buildWaitingUI()
            : _buildDetailsUI(),
      ),
      floatingActionButton: activeCase == null ? FloatingActionButton(
        onPressed: _simulateIntent,
        backgroundColor: Colors.green,
        child: const Icon(Icons.flash_on, color: Colors.white),
      ) : null,
    );
  }

  Widget _buildWaitingUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi_find, size: 80, color: Colors.grey),
        const SizedBox(height: 20),
        const Text('Esperando Intent de App 3...', style: TextStyle(fontSize: 18, color: Colors.grey)),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Recibe el Intent de tus compañeros o usa el botón ⚡ para probar.',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildDetailsUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              height: 120, width: double.infinity,
              decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
              child: const Icon(Icons.pets, size: 60, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¡${activeCase!.petName} está a salvo!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Divider(),
                  _infoTile(Icons.home, 'Refugio', activeCase!.shelterName),
                  _infoTile(Icons.location_on, 'Dirección', activeCase!.shelterAddress),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapViewScreen(data: activeCase!)),
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('VER EN EL MAPA (EXAMEN)'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(onPressed: () => setState(() => activeCase = null), child: const Center(child: Text('Reiniciar Prueba'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(child: Text('$label: $value', style: const TextStyle(fontSize: 14))),
      ]),
    );
  }

  void _simulateIntent() {
    setState(() {
      activeCase = ShelterMatchCase(
        petId: "ID-PROYECTO-X",
        petName: "Dante",
        shelterName: "Refugio San Roque",
        shelterAddress: "Quito, Calle de los Milagros",
        shelterLat: -0.2248,
        shelterLng: -78.5154,
        contactPhone: "0987654321",
      );
    });
  }
}

class MapViewScreen extends StatelessWidget {
  final ShelterMatchCase data;
  const MapViewScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(data.shelterLat, data.shelterLng);
    
    return Scaffold(
      appBar: AppBar(title: Text('Ubicación: ${data.petName}')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: position, zoom: 17),
        markers: {
          Marker(
            markerId: const MarkerId('shelter'),
            position: position,
            infoWindow: InfoWindow(title: data.shelterName, snippet: 'Punto de Reencuentro'),
          ),
        },
      ),
    );
  }
}
