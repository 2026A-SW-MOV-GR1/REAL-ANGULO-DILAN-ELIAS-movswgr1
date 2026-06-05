import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _searchPost(PostProvider provider) {
    final id = int.tryParse(_idController.text);
    if (id != null) {
      provider.fetchPost(id).then((_) {
        if (provider.post != null) {
          _titleController.text = provider.post!.title;
          _bodyController.text = provider.post!.body;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese un ID válido')),
      );
    }
  }

  void _updatePost(PostProvider provider) async {
    final success = await provider.updatePost(
      _titleController.text,
      _bodyController.text,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actualización simulada exitosa'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Conectividad REST')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID del Post',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !provider.isLoading,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: provider.isLoading ? null : () => _searchPost(provider),
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.errorMessage != null)
              Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (provider.post != null) ...[
              Text('ID: ${provider.post!.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                enabled: !provider.isLoading,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Cuerpo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                enabled: !provider.isLoading,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.isLoading ? null : () => _updatePost(provider),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text('Actualizar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
