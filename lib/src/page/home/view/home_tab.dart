import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_app/src/page/commom_widgets/custom_headline_text.dart';
import 'package:lab_app/src/page/commom_widgets/custom_shimmer.dart';
import 'package:lab_app/src/page/home/controller/home_controller.dart';
import 'package:lab_app/src/page/home/view/components/category_item.dart';
import 'package:lab_app/src/page/home/view/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartAnimation = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  itemSelectedCartAnimation(GlobalKey globalKey) {
    runAddToCartAnimation(globalKey);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(100),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const CustomHeadlineText(
          textSize: 30,
          color: Colors.green,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              top: 17,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                label: const Text("2"),
                offset: const Offset(9, -12),
                child: AddToCartIcon(
                  key: globalKeyCartAnimation,
                  icon: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.green,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartAnimation,
        previewCurve: Curves.ease,
        previewDuration: const Duration(milliseconds: 100),
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCartAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: "Pesquise aqui..",
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: !controller.isLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return CategoryItem(
                              categories: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                              onPressed: () {
                                controller.selectCategories(
                                    controller.allCategories[index]);
                              },
                            );
                          },
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(width: 5),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            8,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10),
                              child: CustomShimmer(
                                height: 30,
                                width: 70,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isLoading
                      ? GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 11.5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (context, index) {
                            return ItemTile(
                              items: controller.allProducts[index],
                              cartAnimationMethod: itemSelectedCartAnimation,
                            );
                          },
                        )
                      : GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 11.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(
                            8,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
