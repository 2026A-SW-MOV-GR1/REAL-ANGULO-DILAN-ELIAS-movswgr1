import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/secret_model.dart';
import '../providers/secret_provider.dart';

class SecretsScreen extends StatefulWidget {
  const SecretsScreen({super.key});

  @override
  State<SecretsScreen> createState() => _SecretsScreenState();
}

class _SecretsScreenState extends State<SecretsScreen> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  StorageType _selectedStorage = StorageType.sharedPreferences;

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _saveSecret(SecretProvider provider) async {
    final key = _keyController.text.trim();
    final value = _valueController.text.trim();

    if (key.isEmpty || value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete clave y valor')),
      );
      return;
    }

    await provider.saveSecret(key, value, _selectedStorage);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Secreto guardado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      _valueController.clear();
    }
  }

  void _retrieveSecret(SecretProvider provider) async {
    final key = _keyController.text.trim();
    if (key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese una clave para buscar')),
      );
      return;
    }

    await provider.getSecret(key, _selectedStorage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SecretProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Secretos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Almacenamiento Seguro de Datos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _keyController,
              decoration: const InputDecoration(
                labelText: 'Clave',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.vpn_key),
              ),
              enabled: !provider.isLoading,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.security),
              ),
              enabled: !provider.isLoading,
            ),
            const SizedBox(height: 20),
            const Text('Seleccionar Tipo de Almacenamiento:'),
            ListTile(
              title: const Text('SharedPreferences'),
              leading: Radio<StorageType>(
                value: StorageType.sharedPreferences,
                groupValue: _selectedStorage,
                onChanged: provider.isLoading
                    ? null
                    : (value) => setState(() => _selectedStorage = value!),
              ),
            ),
            ListTile(
              title: const Text('Secure Storage'),
              leading: Radio<StorageType>(
                value: StorageType.secureStorage,
                groupValue: _selectedStorage,
                onChanged: provider.isLoading
                    ? null
                    : (value) => setState(() => _selectedStorage = value!),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : () => _saveSecret(provider),
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : () => _retrieveSecret(provider),
                    icon: const Icon(Icons.search),
                    label: const Text('Recuperar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.lastRetrievedValue != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    const Text('Valor Recuperado:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(
                      provider.lastRetrievedValue!,
                      style: TextStyle(
                        fontSize: 20,
                        color: provider.lastRetrievedValue == 'No encontrado'
                            ? Colors.red
                            : Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
