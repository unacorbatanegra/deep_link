import 'package:deep_link/src/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/product/product_domain.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _isLoading = ValueNotifier(true);
  Object? error;
  List<Product> products = [];
  final productsDomain = GetIt.I<ProductDomain>();
  void init() async {
    final result = await productsDomain.getProducts();
    if (result.isError()) {
      error = result.getError();
    } else {
      products = result.getValue().products;
    }

    _isLoading.value = false;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (ctx, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              final product = products[index];
              return ListTile(
                leading: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.network(
                    product.thumbnail,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              ),
                  ),
                ),
                onTap: () => onTap(product),
                title: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: IconButton(
                  onPressed: () => onTap(product),
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.black,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onTap(Product product) {
    context.push(
      '/products/${product.id}',
      // extra: {'product': product},
    );
  }
}
