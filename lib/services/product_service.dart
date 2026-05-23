import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/product.dart';

class ProductService {
  final String _endpoint = ApiConstants.productsEndpoint;
  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_endpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Failed to load products. Status: ${response.statusCode}',
      );
    }
  }

  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _jsonHeaders,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    } else {
      throw Exception(
        'Failed to create product. Status: ${response.statusCode}',
      );
    }
  }

  Future<void> updateProduct(Product product) async {
    if (product.id == null)
      throw Exception('Cannot update a product without an id.');

    final response = await http.put(
      Uri.parse('$_endpoint/${product.id}'),
      headers: _jsonHeaders,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update product. Status: ${response.statusCode}',
      );
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$_endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete product. Status: ${response.statusCode}',
      );
    }
  }
}
