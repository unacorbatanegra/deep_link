import 'package:deep_link/src/core/api_service.dart';
import 'package:tie_fp/tie_fp.dart';
import 'package:tie_fp_dio/tie_fp_dio.dart';

import '../../models/models.dart';

abstract class ProductsRepository {
  Future<Result<ProductResp>> getProducts();
  Future<Result<Product>> getProduct(String id);
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ApiRepository api;

  ProductsRepositoryImpl(this.api);

  @override
  Future<Result<Product>> getProduct(String id) =>
      api.dio.get('/products/$id').toResult(
            serializer: Product.fromJson,
          );

  @override
  Future<Result<ProductResp>> getProducts() =>
      api.dio.get('/products').toResult(
            serializer: ProductResp.fromJson,
          );
}
