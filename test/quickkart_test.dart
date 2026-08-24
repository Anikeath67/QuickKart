import 'package:flutter_test/flutter_test.dart';
import 'package:quickkart/models/product.dart';
import 'package:quickkart/providers/cart_provider.dart';

void main() {
  test('cart quantity and total work correctly', () {
    const apple = Product(
      id: '1',
      name: 'Fresh Apples',
      emoji: '🍎',
      price: 120,
    );

    final cart = CartProvider();

    cart.addToCart(apple);
    cart.addToCart(apple);

    expect(cart.quantityFor(apple), 2);
    expect(cart.totalItems, 2);
    expect(cart.totalAmount([apple]), 240);

    cart.decreaseQuantity(apple);
    expect(cart.quantityFor(apple), 1);
  });
}
