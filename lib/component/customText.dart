import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  FontWeight weight ;
  TextAlign? align;


  CustomText({required this.text, required this.color, required this.size, required this.weight, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
