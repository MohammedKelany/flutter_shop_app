import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/model/favorite_model.dart';

enum ToastStates {
  SUCCESS,
  WIRNINNG,
  ERROR,
}

void getToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.WIRNINNG:
      return Colors.yellow;
  }
}

Widget emptyBody({
  required String text,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.queue,
          size: 100,
          color: Colors.black12,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Please Add Some Items in $text',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

Widget buildListItem(
  model, {
  bool isOldPrice = true,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: double.infinity,
      height: 120,
      child: ColoredBox(
        color: Colors.white,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image.toString()),
                  height: 120,
                  width: 120,
                ),
                if (isOldPrice == true)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Text(
                      model.name.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${model.price.toString()}\$ ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Colors.blue,
                              fontSize: 10,
                            ),
                          ),
                          if (isOldPrice == true)
                            Text(
                              (model.price == model.oldPrice)
                                  ? ''
                                  : "${model.oldPrice.toString()}\$",
                              style: const TextStyle(
                                height: 1.2,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          GetBuilder<ShopController>(
                            init: ShopController(),
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
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
