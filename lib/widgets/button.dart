import 'package:calculator/consts/colors.dart';
import 'package:calculator/widgets/text.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
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
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: width / 6,
        width: width / 6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.color,
              widget.color.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(width * 0.05),
          border: Border.all(
            color: ColorClass.white.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.3),
              blurRadius: _isPressed ? 5 : 10,
              offset: _isPressed ? const Offset(0, 2) : const Offset(0, 5),
            ),
          ],
        ),
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.95 : 1.0),
        child: TextWidget(
          width: width,
          text: widget.text,
          fontSize: width * 0.055,
          fontWeight: FontWeight.bold,
          color: ColorClass.white,
        ),
      ),
    );
  }
}
