import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/domains.dart';
import '../../../models/models.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final Product? product;
  const ProductPage({
    super.key,
    required this.id,
    this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _isLoading = ValueNotifier(true);

  Object? error;
  late Product product;
  final productsDomain = GetIt.I<ProductDomain>();
  void init() async {
    if (widget.product != null) {
      product = widget.product!;
    } else {
      final result = await productsDomain.getProduct(widget.id);
      if (result.isError()) {
        error = result.getError();
      } else {
        product = result.getValue();
      }
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (ctx, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    // height: 48,
                    child: Image.network(
                      product.thumbnail,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price: ${product.price}',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add to cart'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
