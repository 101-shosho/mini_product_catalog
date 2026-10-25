
/*
Lifecycle answers:
a) initState, didChangeDependencies, build.
b) setState causes build to run again.
c) deactivate runs when the widget is removed from the tree.
   dispose runs when it is permanently removed.
d) didChangeDependencies runs when MediaQuery size changes.

go_router answers:
1) go replaces the current location; push opens a page on top.
2) Use goNamed from Login to Products, and pushNamed for Details.
3) Query example: /products?user=Guest
   Path example: /details/Laptop/1200

Navigator Part 2 (commented example):
// Navigator.pushNamed(context, '/products');
// final result = await Navigator.push<String>(
//   context,
//   MaterialPageRoute(
//     builder: (context) => DetailsPage(
//       name: 'Laptop',
//       price: 1200,
//     ),
//   ),
// );
// Navigator.pop(context, 'Laptop added to cart');
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_page.dart';
import 'products_page.dart';
import 'details_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        return ProductsPage(
          username: state.uri.queryParameters['user'] ?? 'Guest',
        );
      },
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) {
        return DetailsPage(
          name: state.pathParameters['name']!,
          price: double.tryParse(
            state.pathParameters['price']!,
          ) ??
              0,
        );
      },
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mini Product Catalog',
      routerConfig: router,
    );
  }
}
