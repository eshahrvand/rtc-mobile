import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

class RtcDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final bool isDashed;

  const RtcDivider({
    super.key,
    this.color,
    this.height,
    this.width,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.grayPalette.shade200;
    final effectiveHeight = height ?? 1;

    if (isDashed) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = width ?? constraints.constrainWidth();
          return SizedBox(
            width: boxWidth,
            height: effectiveHeight,
            child: CustomPaint(
              painter: _DashedLinePainter(
                color: effectiveColor,
                strokeWidth: effectiveHeight,
              ),
            ),
          );
        },
      );
    }

    return Container(
      width: width ?? double.infinity,
      height: effectiveHeight,
      color: effectiveColor,
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    this.dashWidth = 4,
    this.dashSpace = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
