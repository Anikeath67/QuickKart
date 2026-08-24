import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    // Simulates a REST API request.
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this is where an HTTP request would be made.
    return const [
      Product(id: '1', name: 'Fresh Apples', emoji: '🍎', price: 120),
      Product(id: '2', name: 'Milk', emoji: '🥛', price: 60),
      Product(id: '3', name: 'Bread', emoji: '🍞', price: 45),
    ];
  }
}
