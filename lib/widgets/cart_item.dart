import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Product product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final quantity = cart.quantityFor(product);
    final itemTotal = product.price * quantity;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Text(product.emoji, style: const TextStyle(fontSize: 30)),
        title: Text(product.name,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('₹${product.price.toStringAsFixed(0)} × $quantity'),
        trailing: Text(
          '₹${itemTotal.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
