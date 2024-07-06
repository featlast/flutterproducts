import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_crud/core/providers/product_provider.dart';
import 'package:products_crud/data/models/product_models.dart';
import 'package:products_crud/presentation/widget/show_modal_product.dart';
import '../widget/product_list_tile.dart';

class ProductUi extends ConsumerStatefulWidget {
  const ProductUi({super.key});

  @override
  ProductUiState createState() => ProductUiState();
}

class ProductUiState extends ConsumerState<ProductUi> {
  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).reloadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 46, 46),
        centerTitle: true,
        title: const Text(
          'Listado De Productos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/add.png',
              width: 32, // Ajusta el tamaño según necesites
              height: 32,
            ),
            // label: const Text('Agregar'),
            onPressed: () {
              //Call widget functions for add new product or edit
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.5,
                    child: ShowModalProduct(
                      onAdd: (code, description, price, quantity) async {
                        final newProduct = Product(
                          code: code,
                          description: description,
                          price: price,
                          quantity: quantity,
                        );
                        await ref
                            .read(productControllerProvider.notifier)
                            .addProduct(newProduct);
                      },
                    ),
                  );
                },
              );
            },
            // child: const Text('Agregar Producto'),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Text(
                    'Productos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    'Acciones',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.when(
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, stackTrace) => Text('Error: $error'),
              data: (productList) {
                if (productList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay productos disponibles',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                // Load list products in a ListView
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(productControllerProvider.notifier)
                        .loadProductsFromServer();
                  },
                  child: ListView.separated(
                    itemCount: productList.length + 1,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 2.0,
                        height: 1.0,
                      );
                    },
                    itemBuilder: (context, index) {
                      if (index == productList.length) {
                        // Este es el último elemento
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No hay más productos',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        );
                      }
                      final product = productList[index];
                      return ProductTile(product: product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
