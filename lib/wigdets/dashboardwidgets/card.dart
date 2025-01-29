import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dasboardcards extends StatelessWidget {
  const dasboardcards(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.color,
      required this.Icon,
      required this.page});

  final double width;
  final double height;
  final title;
  final color;
  final Icon;
  final page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(page),
      child: Container(
        width: width * 0.45,
        height: height * 0.15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
