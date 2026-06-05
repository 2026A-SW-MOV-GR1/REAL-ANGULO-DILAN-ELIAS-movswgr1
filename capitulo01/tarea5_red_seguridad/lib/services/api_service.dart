import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../utils/logger.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<Post> getPost(int id) async {
    try {
      Logger.info('GET: Solicitando post con id $id');
      final response = await http.get(Uri.parse('$_baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        Logger.debug('GET: Respuesta exitosa para post $id');
        return Post.fromJson(json.decode(response.body));
      } else {
        Logger.error('GET: Error ${response.statusCode} al obtener post $id');
        throw Exception('Error al obtener el post: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('GET: Error de red', e);
      rethrow;
    }
  }

  Future<bool> updatePost(Post post) async {
    try {
      Logger.info('PUT: Actualizando post con id ${post.id}');
      final response = await http.put(
        Uri.parse('$_baseUrl/posts/${post.id}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 200) {
        Logger.debug('PUT: Actualización exitosa para post ${post.id}');
        return true;
      } else {
        Logger.error('PUT: Error ${response.statusCode} al actualizar post ${post.id}');
        return false;
      }
    } catch (e) {
      Logger.error('PUT: Error de red', e);
      rethrow;
    }
  }
}
