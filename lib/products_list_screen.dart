import 'package:flutter/material.dart';
import 'package:paggination_practice/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  // Future<void> fetchProducts() async {
  //   try {
  //     final response = await http.get(Uri.parse('${base_url}page=$page'));
  //     print(Uri.parse('${base_url}page=$page'));
  //     if (response.statusCode == 200) {
  //       final json = response.body;
  //       print(json);
  //       var product = ProductsResponseModel.fromJson(jsonDecode(json));

  //       setState(() {
  //         products = product.data;
  //         page = page + 1;
  //       });

  //       print("Product length is ${products.length}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> fetchMoreProducts() async {
  //   try {
  //     if (isLoadingMoreData) return;
  //     isLoadingMoreData = true;
  //     print(page);
  //     print("Fetching more products");
  //     final response = await http.get(Uri.parse('${base_url}page=$page'));
  //     print(Uri.parse('${base_url}page=$page'));
  //     if (response.statusCode == 200) {
  //       final json = response.body;
  //       print(json);
  //       var product = ProductsResponseModel.fromJson(jsonDecode(json));
  //       if (products.isNotEmpty) {
  //         page = page + 1;
  //         products.addAll(product.data);
  //         setState(() {
  //           isLoadingMoreData = false;
  //         });
  //         print("Already have the data");
  //       }

  //       print("Product length is ${products.length}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future refresh() async {
  //   setState(() {
  //     isLoadingMoreData = false;
  //     page = 1;
  //     products.clear();
  //   });
  //   fetchProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ProductsProvider()),
      child: const ProductListScreenContent(),
    );
  }
}

class ProductListScreenContent extends StatefulWidget {
  const ProductListScreenContent({super.key});

  @override
  State<ProductListScreenContent> createState() =>
      _ProductListScreenContentState();
}

class _ProductListScreenContentState extends State<ProductListScreenContent> {
  late final ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    context.read<ProductsProvider>().fetchProducts();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<ProductsProvider>().fetchMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ProductsProvider>(
      builder: (context, value, child) {
        return SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: RefreshIndicator(
                    onRefresh: value.refresh,
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: value.products.length + 1,
                        itemBuilder: ((context, index) {
                          if (index < value.products.length) {
                            final product = value.products.elementAt(index);
                            return ListTile(
                              onTap: () {
                                //  _showSimpleDialog();
                              },
                              minVerticalPadding: 50,
                              subtitle: Text(
                                product.message,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    'http://20.212.227.60:3007/${product.icon}',
                                  )),
                              title: Text(
                                product.title,
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),
                  )),
            )

            // context.read<ProductsProvider>().isMoreDataLoading.value == true
            //     ? const Padding(
            //         padding: EdgeInsets.only(top: 10, bottom: 40),
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       )
            //     : Container()
          ],
        ));
      },
    ));
  }
}
