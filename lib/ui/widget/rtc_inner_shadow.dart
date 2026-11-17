import 'package:flutter/material.dart';

class RtcInnerShadow extends StatelessWidget {
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Widget? child;

  const RtcInnerShadow({
    super.key,
    required this.shadows,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RtcInnerShadowPainter(
        shadows: shadows,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}

class _RtcInnerShadowPainter extends CustomPainter {
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;
  final Color? backgroundColor;

  const _RtcInnerShadowPainter({
    required this.shadows,
    required this.borderRadius,
    this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    if (backgroundColor != null) {
      canvas.drawRRect(rrect, Paint()..color = backgroundColor!);
    }

    for (final shadow in shadows) {
      final shadowRect = rect.inflate(shadow.blurRadius * 2 + shadow.spreadRadius);
      final shadowPaint = Paint()..color = shadow.color;
      final sigma = shadow.blurSigma;
      if (sigma > 0) {
        shadowPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);
      }

      canvas.save();
      canvas.clipRRect(rrect);

      final shadowPath = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(shadowRect)
        ..addRRect(rrect.deflate(shadow.spreadRadius).shift(-shadow.offset));

      canvas.drawPath(shadowPath, shadowPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _RtcInnerShadowPainter oldDelegate) =>
      oldDelegate.shadows != shadows ||
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.backgroundColor != backgroundColor;
}
