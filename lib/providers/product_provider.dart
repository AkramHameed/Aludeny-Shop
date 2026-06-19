
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get allProducts => _allProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ProductProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allProducts = await ApiService.fetchProducts();
      
      _categories =
          _allProducts.map((p) => p.category).toSet().toList()..sort();
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category) {
    return _allProducts.where((p) => p.category == category).toList();
  }
}
