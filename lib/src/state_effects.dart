class GlassStateEffects {
  // ホバー状態での調整（例：明るさの上昇、ぼかしの減少）
  final double hoverBrightnessDelta;
  final double hoverBlurReduction;

  // フォーカス状態での調整
  final double focusBrightnessDelta;
  final double focusBlurReduction;

  // タッチ/ドラッグ（プレス）状態での調整
  final double pressBrightnessDelta;
  final double pressBlurReduction;

  const GlassStateEffects({
    this.hoverBrightnessDelta = 0.1,
    this.hoverBlurReduction = 2.0,
    this.focusBrightnessDelta = 0.05,
    this.focusBlurReduction = 1.0,
    this.pressBrightnessDelta = 0.15,
    this.pressBlurReduction = 3.0,
  });
}
