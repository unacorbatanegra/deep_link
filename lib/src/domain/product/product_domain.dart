import 'package:tie_fp/tie_fp.dart';

import '../../models/models.dart';
import '../../repositories/product/product_repository.dart';

abstract class ProductDomain {
  Future<Result<ProductResp>> getProducts();
  Future<Result<Product>> getProduct(String id);
}

class ProductDomainImpl implements ProductDomain {
  final ProductsRepository repo;

  ProductDomainImpl(this.repo);

  @override
  Future<Result<ProductResp>> getProducts() => repo.getProducts();

  @override
  Future<Result<Product>> getProduct(String id) => repo.getProduct(id);
}
