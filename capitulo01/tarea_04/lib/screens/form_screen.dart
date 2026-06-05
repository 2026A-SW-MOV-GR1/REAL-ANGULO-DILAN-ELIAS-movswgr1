import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/native_service.dart';

class FormScreen extends StatefulWidget {
  final ItemModel? itemToEdit;
  final Function(ItemModel) onSave;

  const FormScreen({
    super.key,
    this.itemToEdit,
    required this.onSave,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _subtituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _imagenUrlController;

  late DateTime _selectedDate;
  bool _activo = true;
  final _formKey = GlobalKey<FormState>();

  static const List<String> _imagenes = [
    'https://via.placeholder.com/400x300?text=Elemento+1',
    'https://via.placeholder.com/400x300?text=Elemento+2',
    'https://via.placeholder.com/400x300?text=Elemento+3',
    'https://via.placeholder.com/400x300?text=Elemento+4',
    'https://via.placeholder.com/400x300?text=Elemento+5',
  ];

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.itemToEdit?.titulo ?? '');
    _subtituloController = TextEditingController(text: widget.itemToEdit?.subtitulo ?? '');
    _descripcionController = TextEditingController(text: widget.itemToEdit?.descripcion ?? '');
    _imagenUrlController = TextEditingController(text: widget.itemToEdit?.imagenUrl ?? _imagenes[0]);
    _selectedDate = widget.itemToEdit?.fecha ?? DateTime.now();
    _activo = widget.itemToEdit?.activo ?? true;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _subtituloController.dispose();
    _descripcionController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final item = ItemModel(
      id: widget.itemToEdit?.id ?? DateTime.now().millisecondsSinceEpoch,
      titulo: _tituloController.text,
      subtitulo: _subtituloController.text,
      descripcion: _descripcionController.text,
      fecha: _selectedDate,
      imagenUrl: _imagenUrlController.text,
      activo: _activo,
    );

    final isCreating = widget.itemToEdit == null;
    await NativeService.showToast(
      isCreating
          ? 'Elemento "${item.titulo}" creado'
          : 'Elemento "${item.titulo}" actualizado',
    );

    widget.onSave(item);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.itemToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Elemento' : 'Crear Nuevo Elemento'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Previsualización de imagen
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _imagenUrlController.text,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Imagen no válida'),
                          ],
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Título
              Text('Título', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  hintText: 'Ingresa el título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'El título es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Subtítulo
              Text('Subtítulo', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              TextFormField(
                controller: _subtituloController,
                decoration: InputDecoration(
                  hintText: 'Ingresa el subtítulo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'El subtítulo es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Descripción
              Text('Descripción', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  hintText: 'Ingresa la descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'La descripción es requerida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // URL de imagen
              Text('URL de Imagen', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              TextFormField(
                controller: _imagenUrlController,
                decoration: InputDecoration(
                  hintText: 'URL de la imagen',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.image),
                  suffixIcon: PopupMenuButton(
                    onSelected: (value) {
                      setState(() {
                        _imagenUrlController.text = _imagenes[value];
                      });
                    },
                    itemBuilder: (context) => List.generate(
                      _imagenes.length,
                      (index) => PopupMenuItem(
                        value: index,
                        child: Text('Imagen ${index + 1}'),
                      ),
                    ),
                    child: Icon(Icons.more_vert),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 16),

              // Fecha
              Text('Fecha de Creación', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Icon(Icons.calendar_today, color: Colors.blue),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Switch - Activo
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estado',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          _activo ? 'Activo' : 'Inactivo',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _activo ? Colors.green : Colors.red,
                              ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _activo,
                      onChanged: (value) {
                        setState(() {
                          _activo = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancelar'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSave,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(isEditing ? 'Actualizar' : 'Crear'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


