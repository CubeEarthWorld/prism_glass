import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_painter.dart';

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  // ガラス効果の基本パラメータ
  final double blurAmount; // ここは利用側で最大値 10 とする
  final double refractiveIndex;
  final double opacity;
  final BorderRadius borderRadius;
  final Alignment alignment;
  final BoxBorder? border;
  final Gradient? backgroundGradient;
  final Gradient? borderGradient;
  final Color? tintColor;
  final Duration animationDuration;

  /// リフラクション効果を有効にするかどうか
  final bool enableRefraction;

  const GlassContainer({
    Key? key,
    required this.width,
    required this.height,
    this.child,
    this.blurAmount = 10.0,
    this.refractiveIndex = 1.0,
    this.opacity = 0.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.alignment = Alignment.center,
    this.border,
    this.backgroundGradient,
    this.borderGradient,
    this.tintColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableRefraction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: backgroundGradient ??
            (tintColor != null
                ? LinearGradient(
              colors: [
                tintColor!.withOpacity(opacity),
                tintColor!.withOpacity(opacity * 0.8),
              ],
            )
                : null),
        // 枠線はなし
        border: border ?? Border.all(width: 0, style: BorderStyle.none),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            // 背景ぼかしレイヤー
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurAmount,
                sigmaY: blurAmount,
              ),
              child: Container(color: Colors.transparent),
            ),
            // ガラスのシミュレーションレイヤー
            CustomPaint(
              painter: GlassPainter(
                refractiveIndex: refractiveIndex,
                borderGradient: borderGradient,
                borderRadius: borderRadius,
                enableRefraction: enableRefraction,
              ),
              child: Container(),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
