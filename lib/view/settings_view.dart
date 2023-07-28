import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/shared/network/local/catch_helper.dart';
import 'package:shop_app/view/login_screen.dart';
import 'package:shop_app/view/widgets/text_form_field.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formProfileKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: Get.find(),
      builder: (controller) {
        return Center(
          child: SingleChildScrollView(
            child: Form(
              key: formProfileKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    inputType: TextInputType.text,
                    label: "UserName",
                    validation: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a Text";
                      }
                    },
                    prefixIcon: Icons.verified_user,
                    controller: nameController,
                  ),
                  CustomTextFormField(
                    inputType: TextInputType.emailAddress,
                    label: "EmailAddress",
                    validation: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a Text";
                      }
                    },
                    prefixIcon: Icons.email_outlined,
                    controller: emailController,
                  ),
                  CustomTextFormField(
                    inputType: TextInputType.phone,
                    label: "Phone",
                    onSubmit: (value) {
                      controller.updateProfile(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      );
                    },
                    validation: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a Text";
                      }
                    },
                    prefixIcon: Icons.phone,
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                    condition: !controller.updateLoading,
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formProfileKey.currentState!.validate()) {
                                controller.updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            height: 40,
                            minWidth: double.infinity,
                            textColor: Colors.white,
                            child: const Text("Update"),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: !controller.isLoading,
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              controller.userLogout();
                              CatchHelper.remove("token");
                              Get.off(LoginScreen());
                            },
                            height: 40,
                            minWidth: double.infinity,
                            textColor: Colors.white,
                            child: const Text("Logout"),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
