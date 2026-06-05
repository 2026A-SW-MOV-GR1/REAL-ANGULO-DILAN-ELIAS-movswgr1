class ItemModel {
  final int id;
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final DateTime fecha;
  final String imagenUrl;
  final bool activo;

  ItemModel({
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    required this.fecha,
    required this.imagenUrl,
    this.activo = true,
  });

  /// Copia el objeto con campos opcionales actualizados
  ItemModel copyWith({
    int? id,
    String? titulo,
    String? subtitulo,
    String? descripcion,
    DateTime? fecha,
    String? imagenUrl,
    bool? activo,
  }) {
    return ItemModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      subtitulo: subtitulo ?? this.subtitulo,
      descripcion: descripcion ?? this.descripcion,
      fecha: fecha ?? this.fecha,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      activo: activo ?? this.activo,
    );
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, titulo: $titulo, subtitulo: $subtitulo, fecha: ${fecha.toIso8601String()}, activo: $activo)';
  }
}

