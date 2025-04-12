import 'package:flutter/material.dart';

class statementBox extends StatelessWidget {
  const statementBox({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: height * 0.11,
              width: width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '10,000/=',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1000 lts',
                    style: TextStyle(
                        fontSize: 18, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    '2/2/2202',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: height * 0.02,
          // )
        ],
      ),
    );
  }
}
