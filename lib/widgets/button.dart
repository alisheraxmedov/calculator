import 'package:calculator/consts/colors.dart';
import 'package:calculator/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonWidget extends StatefulWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
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
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final colorScheme = Theme.of(context).colorScheme;
    final Color textColor = isLightTheme &&
            (widget.color == colorScheme.secondary ||
                widget.color == colorScheme.onSecondary)
        ? ColorClass.black
        : ColorClass.white;

    final double size = width / 6;
    final BorderRadius radius = BorderRadius.circular(width * 0.05);
    final Color highlight =
        Color.lerp(widget.color, Colors.white, 0.18) ?? widget.color;
    final Color lowlight =
        Color.lerp(widget.color, Colors.black, 0.10) ?? widget.color;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed == null
          ? null
          : () {
              HapticFeedback.lightImpact();
              widget.onPressed!();
            },
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 130),
        curve: _pressed ? Curves.easeOut : Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: size,
          width: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _pressed
                  ? [
                      widget.color.withValues(alpha: 0.78),
                      widget.color.withValues(alpha: 0.60),
                    ]
                  : [highlight, widget.color, lowlight],
              stops: _pressed ? null : const [0.0, 0.55, 1.0],
            ),
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withValues(alpha: _pressed ? 0.08 : 0.22),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _pressed ? 0.18 : 0.34),
                blurRadius: _pressed ? 4 : 14,
                spreadRadius: _pressed ? 0 : 0.4,
                offset: _pressed ? const Offset(0, 1) : const Offset(0, 6),
              ),
              if (!_pressed)
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.07),
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
            ],
          ),
          child: TextWidget(
            width: width,
            text: widget.text,
            fontSize: width * 0.055,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
