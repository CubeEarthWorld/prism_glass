// lib/src/glass_painter.dart
import 'package:flutter/material.dart';

class GlassPainter extends CustomPainter {
  final double refractiveIndex;
  final Gradient? borderGradient;
  final BorderRadius borderRadius;

  /// リフラクション効果を有効にするかどうか
  final bool enableRefraction;

  const GlassPainter({
    required this.refractiveIndex,
    required this.borderRadius,
    this.borderGradient,
    this.enableRefraction = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 枠線描画：borderGradient が指定されている場合のみ
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
      final double highlightRadius = size.width * 0.3;
      final Offset highlightCenter = Offset(highlightRadius * 0.8, highlightRadius * 0.8);
      final Rect highlightRect = Rect.fromCircle(center: highlightCenter, radius: highlightRadius);
      final Paint highlightPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.2 * (refractiveIndex - 1.0)),
            Colors.transparent,
          ],
          stops: [0.0, 1.0],
        ).createShader(highlightRect)
        ..blendMode = BlendMode.screen;
      canvas.drawCircle(highlightCenter, highlightRadius, highlightPaint);
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
