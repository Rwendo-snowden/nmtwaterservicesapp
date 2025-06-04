import 'package:flutter/material.dart';

class statementBox extends StatelessWidget {
  const statementBox({
    super.key,
    required this.height,
    required this.width,
    required this.amount,
    required this.date,
    required this.liters,
    required this.tokens,
  });

  final double height;
  final double width;
  final amount;
  final date;
  final liters;
  final tokens;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip),
                  ),
                  // Text(
                  //   liters,
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     overflow: TextOverflow.clip,
                  //   ),
                  //  ),
                  // Text(
                  //   date,
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     overflow: TextOverflow.clip,
                  //   ),
                  // ),
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
