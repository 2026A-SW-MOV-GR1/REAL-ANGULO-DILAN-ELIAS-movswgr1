import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/item_card.dart';
import '../widgets/delete_dialog.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  final List<ItemModel> items;
  final Function(ItemModel) onItemDeleted;
  final Function(int?, ItemModel?) onNavigateToForm;

  const ListScreen({
    super.key,
    required this.items,
    required this.onItemDeleted,
    required this.onNavigateToForm,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void _showDeleteDialog(ItemModel item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeleteDialog(
        item: item,
        onConfirm: () {
          widget.onItemDeleted(item);
        },
        onCancel: () {
          // Cancelación
        },
      ),
    );
  }

  void _navigateToForm({int? itemId}) {
    final itemToEdit = itemId != null
        ? widget.items.firstWhere((item) => item.id == itemId, orElse: () => ItemModel(
              id: 0,
              titulo: '',
              subtitulo: '',
              descripcion: '',
              fecha: DateTime.now(),
              imagenUrl: '',
            ))
        : null;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          itemToEdit: itemToEdit,
          onSave: (item) {
            widget.onNavigateToForm(itemId, item);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock CRUD - Lista de Elementos'),
        centerTitle: true,
        elevation: 4,
      ),
      body: widget.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No hay elementos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Presiona el botón + para crear uno',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: widget.items.length,
              padding: EdgeInsets.only(top: 8, bottom: 16),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ItemCard(
                  item: item,
                  onTap: () => _navigateToForm(itemId: item.id),
                  onLongPress: () => _showDeleteDialog(item),
                  onDelete: () => _showDeleteDialog(item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        tooltip: 'Crear nuevo elemento',
        child: Icon(Icons.add),
      ),
    );
  }
}


