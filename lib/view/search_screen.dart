import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/view/shop_layout.dart';
import 'package:shop_app/view/widgets/shared_components.dart';
import 'package:shop_app/view/widgets/text_form_field.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(const ShopLayout());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 30,
          ),
        ),
      ),
      body: GetBuilder<ShopController>(
          init: Get.find(),
          builder: (controller) {
            return Column(
              children: [
                CustomTextFormField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  label: "search",
                  isPass: false,
                  onSubmit: (value) {},
                  onChanged: (value) {
                    controller.searchProducts(value);
                  },
                  validation: (value) {},
                  prefixIcon: Icons.search,
                ),
                if (controller.searchModel != null)
                  Expanded(
                    child: controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListItem(
                                controller.searchModel!.data!.data![index],
                                isOldPrice: false,
                              ),
                              separatorBuilder: (context, index) =>
                                  const ColoredBox(
                                color: Colors.black12,
                                child: SizedBox(
                                  height: 2,
                                ),
                              ),
                              itemCount:
                                  controller.searchModel!.data!.data!.length,
                              shrinkWrap: true,
                            ),
                          ),
                  ),
              ],
            );
          }),
    );
  }
}
