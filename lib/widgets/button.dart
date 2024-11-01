import 'package:calculator/consts/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onPressed;
  const ButtonWidget({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.only(right: 1.0, bottom: 2.0),
          // width: width / 5.1,
          height: width / 5.1,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              width * 0.01,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.09,
              color: ColorClass.white,
            ),
          ),
        ),
      ),
    );
  }
}
