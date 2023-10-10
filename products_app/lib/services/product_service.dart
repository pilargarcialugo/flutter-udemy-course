import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:products_app/models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl= 'flutter-course-a0e61-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  Product? selectedProduct;
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  final storage = const FlutterSecureStorage();

  ProductService() {
    loadProducts();
  }
  
  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json', {'auth': await storage.read(key: 'idToken') ?? ''});
    final response = await http.get(url);
    
    final Map<String, dynamic> productsMap = json.decode(response.body);
    productsMap.forEach((key, value) {
      final product = Product.fromJson(value);
      product.id = key;
      products.add(product);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await create(product);
    } else {
      await update(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> create(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json', {'auth': await storage.read(key: 'idToken') ?? ''});
    final response = await http.post(url, body: product.toRawJson());
    product.id = json.decode(response.body)['name'];
    products.add(product);
    return product.id!;
  }

  Future<String> update(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json', {'auth': await storage.read(key: 'idToken') ?? ''});
    await http.put(url, body: product.toRawJson());

    final productId = product.id;
    final index = products.indexWhere((element) => element.id == productId);
    products[index] = product;
    
    return productId!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct!.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) {
      return null;
    }

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/drcmlciiz/image/upload?upload_preset=flutter-course-images');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    }
    newPictureFile = null;
    return json.decode(response.body)['secure_url'];
  }
}