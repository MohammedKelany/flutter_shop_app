import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/view/widgets/shared_components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
        init: Get.find(),
        builder: (controller) {
          return ConditionalBuilder(
            condition: controller.favoritesModel!.data!.data!.isNotEmpty,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListItem(
                      controller.favoritesModel!.data!.data![index].product!),
                  separatorBuilder: (context, index) => const ColoredBox(
                    color: Colors.black12,
                    child: SizedBox(
                      height: 2,
                    ),
                  ),
                  itemCount: controller.favoritesModel!.data!.data!.length,
                  shrinkWrap: true,
                ),
              );
            },
            fallback: (context) {
              return emptyBody(
                text: "Favorites",
              );
            },
          );
        });
  }
}
