import 'package:flutter/material.dart';

class GlassPainter extends CustomPainter {
  final double glassThickness;
  final double refractiveIndex;
  final Gradient? borderGradient;
  final BorderRadius borderRadius;

  /// リフラクション（屈折）効果を有効にするかどうか
  final bool enableRefraction;

  GlassPainter({
    required this.glassThickness,
    required this.refractiveIndex,
    required this.borderRadius,
    this.borderGradient,
    this.enableRefraction = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. ボーダーグラデーションが指定されている場合、そのグラデーションで枠線を描画
    if (borderGradient != null) {
      final rect = Offset.zero & size;
      final paint = Paint()
        ..shader = borderGradient!.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = glassThickness;
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

    // 2. リフラクション効果のシミュレーション（有効な場合のみ）
    if (enableRefraction && refractiveIndex != 1.0) {
      // シンプルな実装例として、リフラクションの強さに応じた
      // ラジアルグラデーション（ハイライト）を重ね合わせる
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
      // BlendMode.lighten で光が強調されるように
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
    return oldDelegate.glassThickness != glassThickness ||
        oldDelegate.refractiveIndex != refractiveIndex ||
        oldDelegate.borderGradient != borderGradient ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.enableRefraction != enableRefraction;
  }
}
