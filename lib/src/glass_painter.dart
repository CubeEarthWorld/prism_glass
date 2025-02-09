import 'package:flutter/material.dart';

class GlassPainter extends CustomPainter {
  final double refractiveIndex;
  final Gradient? borderGradient;
  final BorderRadius borderRadius;

  final bool enableRefraction;

  const GlassPainter({
    required this.refractiveIndex,
    required this.borderRadius,
    this.borderGradient,
    this.enableRefraction = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 枠線描画：borderGradientが指定されている場合のみ
    if (borderGradient != null) {
      final rect = Offset.zero & size;
      final paint = Paint()
        ..shader = borderGradient!.createShader(rect)
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        ),
        paint,
      );
    }

    // リフラクション効果のシミュレーション（有効な場合のみ）
    if (enableRefraction && refractiveIndex != 1.0) {
      final double offsetAmount = (refractiveIndex - 1.0) * 10.0;
      final Rect refractionRect = Rect.fromLTWH(
        offsetAmount,
        offsetAmount,
        size.width - offsetAmount,
        size.height - offsetAmount,
      );
      final Paint refractionPaint = Paint()
        ..shader = RadialGradient(
          center: Alignment.topLeft,
          radius: 1.0,
          colors: [
            Colors.white.withOpacity(0.2 * (refractiveIndex - 1.0)),
            Colors.transparent,
          ],
          stops: [0.0, 1.0],
        ).createShader(refractionRect)
        ..blendMode = BlendMode.lighten;
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Offset.zero & size,
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        ),
        refractionPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GlassPainter oldDelegate) {
    return oldDelegate.refractiveIndex != refractiveIndex ||
        oldDelegate.borderGradient != borderGradient ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.enableRefraction != enableRefraction;
  }
}
