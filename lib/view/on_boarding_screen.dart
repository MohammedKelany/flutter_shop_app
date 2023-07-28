import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/shared/network/local/catch_helper.dart';
import 'package:shop_app/view/login_screen.dart';
import 'package:shop_app/view/widgets/on_boarding_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();
  List<OnBoardingModel> list = [
    OnBoardingModel("assets/images/OnBoarding.jpg", "OnBoarding Title 1",
        "OnBoarding Body 1"),
    OnBoardingModel("assets/images/OnBoarding.jpg", "OnBoarding Title 2",
        "OnBoarding Body 2"),
    OnBoardingModel("assets/images/OnBoarding.jpg", "OnBoarding Title 3",
        "OnBoarding Body 3"),
  ];
  bool isLast = false;

  void saveOnBoarding() {
    CatchHelper.setData(key: "onBoarding", value: true);
    Get.off(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              saveOnBoarding();
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(
                      () {
                        isLast = false;
                      },
                    );
                  }
                },
                itemBuilder: (context, index) {
                  return OnBoardingBuilder(
                    model: list[index],
                  );
                },
                itemCount: list.length,
                physics: const BouncingScrollPhysics(),
                controller: onBoardingController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: list.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    spacing: 5,
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      saveOnBoarding();
                    } else {
                      onBoardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
