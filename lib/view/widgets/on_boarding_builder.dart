import 'package:flutter/material.dart';
import 'package:shop_app/model/on_boarding_model.dart';

class OnBoardingBuilder extends StatelessWidget {
  const OnBoardingBuilder({Key? key, required this.model}) : super(key: key);
  final OnBoardingModel model;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
         Text(
          model.title,
          style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
         const SizedBox(
          height: 30,
        ),
         Text(
          model.body,
          style:const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
