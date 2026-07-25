import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/shelter_match_case.dart';
import 'services/intent_service.dart';

void main() => runApp(const ExamenApp());

class ExamenApp extends StatelessWidget {
  const ExamenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Reencuentro - Examen Dinámico',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  bool _isMapReady = false;
  ShelterMatchCase? activeCase;
  StreamSubscription? _intentSubscription;
  
  // Ubicación por defecto (Quito) mientras llega el Intent
  static const LatLng _defaultLocation = LatLng(-0.1807, -78.4678);
  
  Set<Marker> _markers = {};

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

  // 1. Revisar si la app se abrió directamente con el Intent (Cold Start)
  Future<void> _checkInitialIntent() async {
    final receivedCase = await IntentService.getInitialCase();
    if (receivedCase != null) {
      _updateMapState(receivedCase);
    }
  }

  // 2. Escuchar si llega un Intent mientras la app está abierta
  void _listenToNewIntents() {
    _intentSubscription = IntentService.onNewCase.listen((receivedCase) {
      _updateMapState(receivedCase);
    });
  }

  void _updateMapState(ShelterMatchCase data) {
    setState(() {
      activeCase = data;
      final position = LatLng(data.shelterLat, data.shelterLng);
      
      // Actualizar Marcador
      _markers = {
        Marker(
          markerId: const MarkerId('active_case_marker'),
          position: position,
          infoWindow: InfoWindow(
            title: '¡Aquí está ${data.petName}!',
            snippet: data.shelterName,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      };

      // Mover Cámara automáticamente
      _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 17),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    setState(() => _isMapReady = true);
    
    // Si ya teníamos datos al cargar el mapa, centramos
    if (activeCase != null) {
      _updateMapState(activeCase!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activeCase == null ? 'Buscando Refugio...' : 'Reencuentro: ${activeCase!.petName}'),
        centerTitle: true,
        backgroundColor: Colors.green.shade100,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: activeCase != null 
                  ? LatLng(activeCase!.shelterLat, activeCase!.shelterLng) 
                  : _defaultLocation,
              zoom: 15.0,
            ),
            markers: _markers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),
          
          if (!_isMapReady)
            const Center(child: CircularProgressIndicator()),

          // Panel de Evidencia (Solo aparece cuando llega la mascota)
          if (activeCase != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                elevation: 10,
                color: Colors.white.withOpacity(0.95),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '¡Mascota ${activeCase!.petName} Evidenciada!',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text('Ubicada en: ${activeCase!.shelterName}', style: const TextStyle(fontSize: 14)),
                      Text('Dirección: ${activeCase!.shelterAddress}', 
                          style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              LatLng(activeCase!.shelterLat, activeCase!.shelterLng), 18),
                          );
                        },
                        icon: const Icon(Icons.gps_fixed),
                        label: const Text('Centrar en Refugio'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
