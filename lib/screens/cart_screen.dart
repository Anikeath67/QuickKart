import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<Product> products;

  const CartScreen({super.key, required this.products});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _placingOrder = false;
  bool _ordered = false;

  Future<void> _placeOrder() async {
    setState(() => _placingOrder = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    setState(() {
      _placingOrder = false;
      _ordered = true;
    });

    context.read<CartProvider>().clearCart();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final total = cart.totalAmount(widget.products);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: _ordered
          ? _orderSuccess()
          : cart.isEmpty
              ? const Center(child: Text('Your cart is empty.'))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...widget.products
                        .where((p) => cart.quantityFor(p) > 0)
                        .map((p) => CartItem(product: p)),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total amount',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Text('₹${total.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: FilledButton(
                                onPressed:
                                    _placingOrder ? null : _placeOrder,
                                child: _placingOrder
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Text('Place Order'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _orderSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle,
                size: 90, color: Colors.green),
            const SizedBox(height: 18),
            const Text('Order Placed',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    _OrderRow(label: 'Order ID', value: 'QK-1001'),
                    SizedBox(height: 12),
                    _OrderRow(label: 'Status', value: 'Order Placed'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String label;
  final String value;

  const _OrderRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
