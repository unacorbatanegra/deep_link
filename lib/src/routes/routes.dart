import 'package:deep_link/src/presentation/pages/products/products_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/login/login_page.dart';
import '../presentation/pages/product/product_page.dart';

extension StateHelp on GoRouterState {
  Map<String, dynamic>? getExtra<T>() {
    if (extra is Map<String, dynamic>) return extra as Map<String, dynamic>?;
    return null;
  }

  T? getExtraValue<T>(String key) => getExtra()?[key];
}

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter? _router;

GoRouter router(String initialRoute) {
  return _router ??= GoRouter(
    initialLocation: initialRoute,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsPage(),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (context, state) => ProductPage(
          id: state.pathParameters['id']!,
          product: state.getExtraValue('product'),
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      )
    ],
  );
}
