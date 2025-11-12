import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart_app/consts/app_constants.dart';
import 'package:shop_smart_app/models/product_model.dart';
import 'package:shop_smart_app/providers/product_provider.dart';
import 'package:shop_smart_app/widgets/custom_app_bar.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/products/ctg_rounded_widget.dart';
import 'package:shop_smart_app/widgets/products/latest_arrival.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Stream<List<ProductModel>> productStream;

  @override
  void initState() {
    productStream = context.read<ProductProvider>().fetchProductsStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),

      body: StreamBuilder<List<ProductModel>>(
        stream: productStream,
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
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Swiper(
                      autoplay: true,
                      itemCount: AppConstants.imagesBanners.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AppConstants.imagesBanners[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },

                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.blueAccent,
                          color: Colors.grey,
                          activeSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(12),

                const CustomTitleText(text: "Latest arrival", fontSize: 22),

                const Gap(12),

                SizedBox(
                  height: size.height * 0.16,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.getProducts.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: const LatestArrivalProductsWidget(),
                      );
                    },
                  ),
                ),
                const Gap(12),
                const CustomTitleText(text: "Categories", fontSize: 22),

                const Gap(12),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(AppConstants.categoriesList.length, (
                    index,
                  ) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
