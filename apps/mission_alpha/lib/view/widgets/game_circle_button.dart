import 'package:flutter/material.dart';

class GameCircleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final EdgeInsets? padding;
  final Color? color;
  final double? size;

  const GameCircleButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.padding,
    this.color,
    this.size,
  });

  @override
  State<GameCircleButton> createState() => _GameCircleButtonState();
}

class _GameCircleButtonState extends State<GameCircleButton> {
  bool _onTapDown = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _onTapDown ? 0.8 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: widget.padding?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color ?? Colors.black45,
        ),
        child: InkWell(
          onTapDown: (_) => _enableTapDown(),
          onTapUp: (_) => _releaseTap(),
          child: widget.child,
        ),
      ),
    );
  }

  void _releaseTap() {
    setState(() {
      _onTapDown = false;
    });
    widget.onTapUp?.call();
  }

  void _enableTapDown() {
    setState(() {
      _onTapDown = true;
    });
    widget.onPressed?.call();
    widget.onTapDown?.call();
  }
}
