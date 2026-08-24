import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _service = ProductService();
  List<Product> _products = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final connection = await Connectivity().checkConnectivity();
      if (connection.contains(ConnectivityResult.none)) {
        throw Exception('No internet connection');
      }

      final products = await _service.fetchProducts();
      if (!mounted) return;
      setState(() {
        _products = products;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Unable to load products. Please check your internet connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = context.watch<CartProvider>().totalItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickKart',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: _products.isEmpty
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(products: _products),
                      ),
                    ),
            icon: Badge(
              isLabelVisible: itemCount > 0,
              label: Text('$itemCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 70,
                color: Colors.grey.shade600,
              ),
              const SizedBox(height: 20),
              const Text(
                'Products unavailable',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Unable to load products.\n'
                'Please check your internet connection.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _loadProducts,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadProducts,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
        children: [
          const Text('Fresh Picks',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text('Simple shopping, quick delivery.',
              style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 22),
          ..._products.map((p) => ProductCard(product: p)),
          const SizedBox(height: 10),
          Consumer<CartProvider>(
            builder: (_, cart, __) => cart.isEmpty
                ? const SizedBox.shrink()
                : FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(products: _products),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label: Text('View Cart (${cart.totalItems})'),
                  ),
          ),
        ],
      ),
    );
  }
}
