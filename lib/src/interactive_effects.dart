import 'package:flutter/material.dart';
import 'state_effects.dart';

typedef GlassBuilder = Widget Function(
    double currentBlur,
    double currentBrightness,
    Color? currentTintColor,
    );

class InteractiveGlassWrapper extends StatefulWidget {
  final GlassBuilder builder;
  final GlassStateEffects? stateEffects;
  final Duration animationDuration;
  final double baseBlur;

  const InteractiveGlassWrapper({
    Key? key,
    required this.builder,
    this.stateEffects,
    required this.animationDuration,
    required this.baseBlur,
  }) : super(key: key);

  @override
  InteractiveGlassWrapperState createState() => InteractiveGlassWrapperState();
}

class InteractiveGlassWrapperState extends State<InteractiveGlassWrapper> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  double get _blurAdjustment {
    double adjustment = 0.0;
    if (_isHovered) adjustment += widget.stateEffects?.hoverBlurReduction ?? 0.0;
    if (_isFocused) adjustment += widget.stateEffects?.focusBlurReduction ?? 0.0;
    if (_isPressed) adjustment += widget.stateEffects?.pressBlurReduction ?? 0.0;
    return adjustment;
  }

  double get _brightnessAdjustment {
    double adjustment = 0.0;
    if (_isHovered) adjustment += widget.stateEffects?.hoverBrightnessDelta ?? 0.0;
    if (_isFocused) adjustment += widget.stateEffects?.focusBrightnessDelta ?? 0.0;
    if (_isPressed) adjustment += widget.stateEffects?.pressBrightnessDelta ?? 0.0;
    return adjustment;
  }

  // 現在の tintColor 補正（brightness 調整を反映させるロジックを後で実装可能）
  Color? get _adjustedTintColor {
    // デモ用として現状は null を返す
    return null;
  }

  void _updateState({bool? hovered, bool? focused, bool? pressed}) {
    setState(() {
      if (hovered != null) _isHovered = hovered;
      if (focused != null) _isFocused = focused;
      if (pressed != null) _isPressed = pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateState(hovered: true),
      onExit: (_) => _updateState(hovered: false),
      child: Focus(
        onFocusChange: (hasFocus) => _updateState(focused: hasFocus),
        child: GestureDetector(
          onTapDown: (_) => _updateState(pressed: true),
          onTapUp: (_) => _updateState(pressed: false),
          onTapCancel: () => _updateState(pressed: false),
          onPanUpdate: (details) {
            // ドラッグ操作に応じたエフェクト（反射方向の変化等）の実装を追加可能
          },
          child: widget.builder(
            (widget.baseBlur - _blurAdjustment).clamp(0.0, double.infinity),
            _brightnessAdjustment,
            _adjustedTintColor,
          ),
        ),
      ),
    );
  }
}
