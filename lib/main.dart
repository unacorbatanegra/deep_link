import 'package:app_links/app_links.dart';
import 'package:deep_link/src/core/deep_link.dart';
import 'package:deep_link/src/domain/product/product_domain.dart';
import 'package:deep_link/src/repositories/product/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/core/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<ProductDomain>(
    ProductDomainImpl(
      ProductsRepositoryImpl(ApiRepository(null)),
    ),
  ); // esto es para forzar que no compile para probar el runner
  DeepLink.setup(AppLinks());
  runApp(const MyApp());
}
