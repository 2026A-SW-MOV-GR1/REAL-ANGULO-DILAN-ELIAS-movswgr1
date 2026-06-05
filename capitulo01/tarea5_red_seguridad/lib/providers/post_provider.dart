import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../utils/logger.dart';

class PostProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Post? _post;
  bool _isLoading = false;
  String? _errorMessage;

  Post? get post => _post;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPost(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _post = await _apiService.getPost(id);
      Logger.info('PostProvider: Post $id cargado');
    } catch (e) {
      _post = null;
      _errorMessage = 'No se pudo encontrar el post con ID $id o hay un error de red.';
      Logger.error('PostProvider: Error al cargar post $id', e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updatePost(String title, String body) async {
    if (_post == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedPost = _post!.copyWith(title: title, body: body);
      final success = await _apiService.updatePost(updatedPost);
      
      if (success) {
        _post = updatedPost;
        Logger.info('PostProvider: Post ${_post!.id} actualizado correctamente');
      }
      return success;
    } catch (e) {
      Logger.error('PostProvider: Error al actualizar post', e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPost() {
    _post = null;
    _errorMessage = null;
    notifyListeners();
  }
}
