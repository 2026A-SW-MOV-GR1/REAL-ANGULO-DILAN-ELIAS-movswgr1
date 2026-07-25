import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const LifecycleChallengeApp());
}

class LifecycleChallengeApp extends StatelessWidget {
  const LifecycleChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifecycle & State Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with WidgetsBindingObserver {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Equivalente a onCreate
    developer.log('LIFECYCLE: onCreate / initState', name: 'LifecycleApp');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Equivalente a onDestroy
    developer.log('LIFECYCLE: onDestroy / dispose', name: 'LifecycleApp');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.resumed:
        // Equivalente a onResume
        developer.log('LIFECYCLE: onResume / resumed', name: 'LifecycleApp');
        break;
      case AppLifecycleState.inactive:
        // Equivalente a onPause
        developer.log('LIFECYCLE: onPause / inactive', name: 'LifecycleApp');
        break;
      case AppLifecycleState.paused:
        // Equivalente a onStop
        developer.log('LIFECYCLE: onStop / paused', name: 'LifecycleApp');
        break;
      case AppLifecycleState.detached:
        developer.log('LIFECYCLE: detached', name: 'LifecycleApp');
        break;
      case AppLifecycleState.hidden:
        developer.log('LIFECYCLE: hidden', name: 'LifecycleApp');
        break;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    developer.log('STATE: Contador incrementado a $_counter', name: 'LifecycleApp');
  }

  @override
  Widget build(BuildContext context) {
    // El método build se llama en cada recreación (incluyendo rotación)
    developer.log('LIFECYCLE: build (Se llamó por rotación o cambio de estado)', name: 'LifecycleApp');
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Batalla del Estado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Has presionado el botón esta cantidad de veces:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Prueba: Incrementa a 10 y rota la pantalla.',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
