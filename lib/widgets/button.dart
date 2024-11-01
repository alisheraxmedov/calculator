import 'package:calculator/widgets/text.dart';
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: width / 6,
        width: width / 6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            width * 0.05,
          ),
        ),
        child: TextWidget(
          width: width,
          text: text,
          fontSize: width * 0.055,
        ),
        // child: Text(
        //   text,
        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //         fontSize: width * 0.055,
        //       ),
        // ),
      ),
    );
  }
}
