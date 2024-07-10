import 'package:flutter/material.dart';
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  TextDirection textDirection ;
  double size;
  BigText({Key? key,this.color = const Color(0xff242C3B),
    required this.text, this.size=0, this.textDirection= TextDirection.rtl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: 1, textDirection: textDirection,
      style: TextStyle(
        color: color, fontSize: size==0?18:size,
        fontFamily: "Lemonada", fontWeight: FontWeight.w600,
      ),
    );
  }
}