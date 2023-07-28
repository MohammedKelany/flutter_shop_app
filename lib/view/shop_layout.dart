import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/view/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
        init: Get.put(ShopController()),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              leading: const Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Salla",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              condition: controller.homeModel != null &&
                  controller.categoryModel != null &&
                  controller.favoritesModel != null &&
                  controller.userProfile != null,
              builder: (context) {
                return controller.screens[controller.currentIndex];
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              items: controller.items,
              currentIndex: controller.currentIndex,
              onTap: (int index) {
                controller.changeCurrentIndex(index);
              },
            ),
          );
        });
  }
}
