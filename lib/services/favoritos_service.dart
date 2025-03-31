import 'package:flutter/foundation.dart';

class FavoritosService extends ChangeNotifier {
  final List<Map<String, dynamic>> _pastelesFavoritos = [];
  final List<Map<String, dynamic>> _reposterosFavoritos = [];

  List<Map<String, dynamic>> get pastelesFavoritos => _pastelesFavoritos;
  List<Map<String, dynamic>> get reposterosFavoritos => _reposterosFavoritos;

  void agregarPastelFavorito(Map<String, dynamic> pastel) {
    if (!_pastelesFavoritos.any((p) => p['id'] == pastel['id'])) {
      _pastelesFavoritos.add(pastel);
      notifyListeners();
    }
  }

  void quitarPastelFavorito(String id) {
    _pastelesFavoritos.removeWhere((p) => p['id'] == id);
    notifyListeners();
  }

  void agregarReposteroFavorito(Map<String, dynamic> repostero) {
    if (!_reposterosFavoritos.any((r) => r['id'] == repostero['id'])) {
      _reposterosFavoritos.add(repostero);
      notifyListeners();
    }
  }

  void quitarReposteroFavorito(String id) {
    _reposterosFavoritos.removeWhere((r) => r['id'] == id);
    notifyListeners();
  }

  bool esPastelFavorito(String id) {
    return _pastelesFavoritos.any((p) => p['id'] == id);
  }

  bool esReposteroFavorito(String id) {
    return _reposterosFavoritos.any((r) => r['id'] == id);
  }
} 