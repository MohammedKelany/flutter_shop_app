import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: Get.find(),
      builder: (controller) {
        return homeBuilder(controller.homeModel, controller.categoryModel);
      },
    );
  }

  Widget homeBuilder(HomeModel? homeModel, CategoryModel? categoryModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel!.data!.banners?.map(
              (e) {
                return Image(
                  image: NetworkImage(e.image.toString()),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            ).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 30),
              enableInfiniteScroll: true,
              initialPage: 0,
              reverse: false,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoryModel!.data!.data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 5,
                    ),
                    itemCount: categoryModel!.data!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "New Products",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ColoredBox(
            color: Colors.grey.shade300,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.7,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(
                homeModel.data!.products!.length,
                (index) {
                  return buildGridItem(homeModel.data!.products![index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildGridItem(Products model) {
  return ColoredBox(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image.toString()),
              height: 200,
              width: double.infinity,
            ),
            if (model.price != model.oldPrice)
              const ColoredBox(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                style: const TextStyle(
                    height: 1.2, overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.price.toString()}\$ ',
                    style: const TextStyle(
                      height: 1.2,
                      color: Colors.blue,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    (model.price == model.oldPrice)
                        ? ''
                        : "${model.oldPrice.toString()}\$",
                    style: const TextStyle(
                      height: 1.2,
                      color: Colors.grey,
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<ShopController>(
                      init: Get.find(),
                      builder: (controller) {
                        return CircleAvatar(
                          radius: 15,
                          backgroundColor: controller.favorites[model.id]!
                              ? Colors.blue
                              : Colors.black12,
                          foregroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              controller.changeFavorite(model.id!);
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoryItem(CategoryDataModel model) {
  return InkWell(
    onTap: () {},
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image.toString()),
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
          SizedBox(
            width: 150,
            child: ColoredBox(
              color: Colors.black54,
              child: Text(
                model.name.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
