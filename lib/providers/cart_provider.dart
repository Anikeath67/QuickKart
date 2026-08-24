import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _quantities = {};

  int quantityFor(Product product) => _quantities[product.id] ?? 0;

  void addToCart(Product product) {
    _quantities[product.id] = quantityFor(product) + 1;
    notifyListeners();
  }

  void increaseQuantity(Product product) => addToCart(product);

  void decreaseQuantity(Product product) {
    final current = quantityFor(product);
    if (current <= 1) {
      _quantities.remove(product.id);
    } else {
      _quantities[product.id] = current - 1;
    }
    notifyListeners();
  }

  int get totalItems =>
      _quantities.values.fold(0, (sum, quantity) => sum + quantity);

  double totalAmount(List<Product> products) {
    double total = 0;
    for (final product in products) {
      total += product.price * quantityFor(product);
    }
    return total;
  }

  bool get isEmpty => totalItems == 0;

  void clearCart() {
    _quantities.clear();
    notifyListeners();
  }
}
