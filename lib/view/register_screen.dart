import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/register_controller.dart';
import 'package:shop_app/view/widgets/text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RegisterController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register",
                      style: Theme.of(context).textTheme.headline4),
                  Text(
                    "Register now to get our special offers.",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                      label: "Name",
                      prefixIcon: Icons.verified_user,
                      controller: nameController,
                      validation: (value) {
                        if (value.toString().isEmpty) {
                          return "Name is Empty !!!";
                        }
                        return null;
                      },
                      inputType: TextInputType.emailAddress),
                  CustomTextFormField(
                      label: "Email",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validation: (value) {
                        if (value.toString().isEmpty) {
                          return "Email is Empty !!!";
                        }
                        return null;
                      },
                      inputType: TextInputType.emailAddress),
                  GetBuilder<RegisterController>(
                    builder: (_) {
                      return CustomTextFormField(
                        label: "PassWord",
                        prefixIcon: Icons.lock,
                        isPass: controller.isVisible,
                        suffixIcon: controller.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressed: () {
                          controller.changePassVisibility();
                        },
                        controller: passController,
                        validation: (value) {
                          if (value.toString().isEmpty) {
                            return "PassWord is Empty !!!";
                          }
                          return null;
                        },
                        inputType: TextInputType.visiblePassword,
                        onSubmit: (value) {
                          if (registerFormKey.currentState!.validate()) {}
                        },
                      );
                    },
                  ),
                  CustomTextFormField(
                      label: "PhoneNumber",
                      prefixIcon: Icons.password,
                      controller: phoneController,
                      validation: (value) {
                        if (value.toString().isEmpty) {
                          return "PhoneNumber is Empty !!!";
                        }
                        return null;
                      },
                      inputType: TextInputType.phone),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<RegisterController>(
                    builder: (_) {
                      return ConditionalBuilder(
                        condition: !controller.isLoading,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (registerFormKey.currentState!.validate()) {
                                  controller.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                      phone: phoneController.text);
                                }
                              },
                              height: 40,
                              minWidth: double.infinity,
                              textColor: Colors.white,
                              child: const Text("Submit"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
