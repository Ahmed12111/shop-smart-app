import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/models/product_model.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/widgets/custom_app_bar.dart';
import 'package:shop_smart_app/widgets/custom_text_field.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/product_not_found_widget.dart';
import 'package:shop_smart_app/widgets/products/custom_product_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routName = '/SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchEditingController;
  late FocusNode searchFocusingNode;
  late final Stream<List<ProductModel>> _productStream;
  List<ProductModel> productListSearch = [];

  @override
  void initState() {
    super.initState();
    searchEditingController = TextEditingController();
    searchFocusingNode = FocusNode();
    _productStream = context.read<ProductProvider>().fetchProductsStream();
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    searchFocusingNode.dispose();
    super.dispose();
  }

  void _runSearch(
    String value,
    List<ProductModel> list,
    ProductProvider provider,
  ) {
    setState(() {
      productListSearch = provider.searchQuery(searchText: value, list: list);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = categoryName != null
        ? productProvider.findProductsByCategory(categoryName: categoryName)
        : productProvider.getProducts;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: StreamBuilder<List<ProductModel>>(
          stream: _productStream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (asyncSnapshot.hasError) {
              return Center(
                child: CustomTitleText(text: asyncSnapshot.error.toString()),
              );
            } else if (!asyncSnapshot.hasData) {
              return const Center(
                child: CustomTitleText(text: "No product has been added."),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    onChanged: (value) =>
                        _runSearch(value, productList, productProvider),
                    onFieldSubmited: (value) =>
                        _runSearch(value, productList, productProvider),
                    prefixIcon: Icons.search,
                    suffixIcon: Icons.clear,
                    controller: searchEditingController,
                    hintText: "Search",
                    fillColor: Theme.of(context).cardColor,
                    onSuffixIconTap: () {
                      setState(() {
                        searchEditingController.clear();
                        productListSearch.clear();
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const Gap(8),
                  if (searchEditingController.text.isNotEmpty &&
                      productListSearch.isEmpty) ...[
                    ProductNotFoundWidget(
                      onRetry: () {
                        searchEditingController.clear();
                        searchFocusingNode.requestFocus();
                      },
                    ),
                  ],
                  Expanded(
                    child: DynamicHeightGridView(
                      itemCount: searchEditingController.text.isNotEmpty
                          ? productListSearch.length
                          : productList.length,
                      crossAxisCount: 2,
                      builder: (context, index) {
                        final product = searchEditingController.text.isNotEmpty
                            ? productListSearch[index]
                            : productList[index];
                        return CustomProductWidget(
                          productId: product.productId,
                        );
                      },
                    ),
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
