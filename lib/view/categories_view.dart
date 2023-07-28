import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItems(
                  controller.categoryModel!.data!.data![index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: ColoredBox(
                      color: Colors.grey.shade200,
                    ),
                  ),
              itemCount: controller.categoryModel!.data!.data!.length),
        );
      },
    );
  }
}

Widget buildCategoryItems(CategoryDataModel model) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Image(
        image: NetworkImage(model.image!.toString()),
        width: 120,
        height: 120,
      ),
      const SizedBox(
        width: 20,
      ),
      Text(model.name.toString()),
      const Spacer(),
      const Icon(Icons.arrow_forward_ios_outlined),
    ],
  );
}
