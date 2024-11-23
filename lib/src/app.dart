import 'dart:async';

import 'package:deep_link/src/core/deep_link.dart';
import 'package:deep_link/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final initialRoute = ValueNotifier('/products');
  bool isLogged() => true;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: initialRoute,
      builder: (ctx, route, _) => MaterialApp.router(
        title: 'Deep link demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
        ),
        routerConfig: router(route),
      ),
    );
  }

  void init() {
    DeepLink.uriLinkStream.listen(handleLink);
    unawaited(DeepLink.appLink.getInitialLink().then(handleLink));
    if (!isLogged()) {
      initialRoute.value = '/login';
      return;
    }
  }
  
  void handleLink(Uri? uri) {
    if (uri == null) return;
    if (!isLogged()) return;

    final path = uri.path;
    print(path);
    final router = navigatorKey.currentContext!;
    unawaited(router.push(path));
  }
}
