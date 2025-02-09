import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_painter.dart';
import 'interactive_effects.dart';
import 'state_effects.dart';

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  // ガラス効果の基本パラメータ
  final double blurAmount;
  final double glassThickness;
  final double refractiveIndex;
  final double opacity;
  final BorderRadius borderRadius;
  final Alignment alignment;
  final BoxBorder? border;
  final Gradient? backgroundGradient;
  final Gradient? borderGradient;
  final Color? tintColor;
  final Duration animationDuration;

  // 各状態（ホバー、フォーカス、タッチ/ドラッグ）でのエフェクト調整パラメータ
  final GlassStateEffects? stateEffects;

  /// リフラクション（屈折）効果を有効にするかどうか
  final bool enableRefraction;

  const GlassContainer({
    Key? key,
    required this.width,
    required this.height,
    this.child,
    this.blurAmount = 10.0,
    this.glassThickness = 1.0,
    this.refractiveIndex = 1.0,
    this.opacity = 0.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.alignment = Alignment.center,
    this.border,
    this.backgroundGradient,
    this.borderGradient,
    this.tintColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.stateEffects,
    this.enableRefraction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveGlassWrapper(
      stateEffects: stateEffects,
      animationDuration: animationDuration,
      baseBlur: blurAmount,
      builder: (currentBlur, currentBrightness, currentTintColor) {
        return AnimatedContainer(
          duration: animationDuration,
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            // 背景グラデーションまたは tintColor と透明度を用いた塗りつぶし
            gradient: backgroundGradient ??
                (tintColor != null
                    ? LinearGradient(
                  colors: [
                    (currentTintColor ?? tintColor!).withOpacity(opacity),
                    (currentTintColor ?? tintColor!).withOpacity(opacity * 0.8),
                  ],
                )
                    : null),
            border: border ?? Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                // 背景ぼかしレイヤー
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: currentBlur,
                    sigmaY: currentBlur,
                  ),
                  child: Container(color: Colors.transparent),
                ),
                // ガラスの描画（ボーダーグラデーションやリフラクション効果）
                CustomPaint(
                  painter: GlassPainter(
                    glassThickness: glassThickness,
                    refractiveIndex: refractiveIndex,
                    borderGradient: borderGradient,
                    borderRadius: borderRadius,
                    enableRefraction: enableRefraction,
                  ),
                  child: Container(),
                ),
                // コンテンツ表示
                if (child != null) child!,
              ],
            ),
          ),
        );
      },
    );
  }
}
