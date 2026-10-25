
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'product_widgets.dart';

class ProductsPage extends StatefulWidget {
  final String username;

  const ProductsPage({
    super.key,
    required this.username,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int favorites = 0;
  double screenWidth = 0;
  String cartMessage = '';

  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Phone', 'price': 800},
    {'name': 'Headphones', 'price': 100},
    {'name': 'Keyboard', 'price': 50},
    {'name': 'Mouse', 'price': 25},
    {'name': 'Tablet', 'price': 400},
  ];

  @override
  void initState() {
    super.initState();
    print('ProductsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;

    print(
      'ProductsPage: didChangeDependencies '
          '-> width: ${size.width}, height: ${size.height}',
    );
  }

  @override
  Widget build(BuildContext context) {
    print('ProductsPage: build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('Welcome, ${widget.username}'),
                Text('Favorites: $favorites'),
                Text(
                  'Screen width: ${screenWidth.toStringAsFixed(0)}',
                ),
                if (cartMessage.isNotEmpty)
                  Text(
                    cartMessage,
                    style: const TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ),
          Expanded(
            child: screenWidth < 600
                ? ProductsListView(
              products: products,
              onFavoritePressed: () {
                setState(() {
                  favorites++;
                });
              },
              onProductTap: (index) {
                openDetails(index);
              },
            )
                : ProductsGridView(
              products: products,
              onFavoritePressed: () {
                setState(() {
                  favorites++;
                });
              },
              onProductTap: (index) {
                openDetails(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openDetails(int index) async {
    final product = products[index];

    final result = await context.pushNamed<String>(
      'details',
      pathParameters: {
        'name': product['name'].toString(),
        'price': product['price'].toString(),
      },
    );

    if (result != null && mounted) {
      setState(() {
        cartMessage = result;
      });
    }
  }

  @override
  void deactivate() {
    print('ProductsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ProductsPage: dispose');
    super.dispose();
  }
}
