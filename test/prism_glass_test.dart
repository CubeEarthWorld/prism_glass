import 'package:flutter/material.dart';
import 'package:prismglass/prismglass.dart';

void main() => runApp(PrismGlassDemoApp());

class PrismGlassDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrismGlass Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  @override
  _DemoHomePageState createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  // 現在選択中のモード（0: View Mode, 1: Edit Mode）
  int _currentIndex = 0;

  // GlassContainer 用のパラメータ（Edit Mode で変更可能）
  double _blurAmount = 10.0;
  double _glassThickness = 2.0;
  double _refractiveIndex = 1.2;
  double _opacity = 0.5;
  BorderRadius _borderRadius = BorderRadius.circular(20);
  Color _tintColor = Colors.blue;
  bool _enableRefraction = true;

  void _updateParameters(
      double blur,
      double thickness,
      double refractive,
      double opacity,
      BorderRadius radius,
      Color tint,
      bool enableRefraction) {
    setState(() {
      _blurAmount = blur;
      _glassThickness = thickness;
      _refractiveIndex = refractive;
      _opacity = opacity;
      _borderRadius = radius;
      _tintColor = tint;
      _enableRefraction = enableRefraction;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_currentIndex == 0) {
      body = ViewModeScreen();
    } else {
      body = EditModeScreen(
        blurAmount: _blurAmount,
        glassThickness: _glassThickness,
        refractiveIndex: _refractiveIndex,
        opacity: _opacity,
        borderRadius: _borderRadius,
        tintColor: _tintColor,
        enableRefraction: _enableRefraction,
        onParametersChanged: _updateParameters,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PrismGlass Demo'),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'View Mode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Mode',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class ViewModeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景：A～Z のテキストが散在するスクロール可能な領域
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(26, (index) {
                String letter = String.fromCharCode(65 + index);
                return Text(
                  letter * 5,
                  style: TextStyle(fontSize: 32, color: Colors.grey[300]),
                );
              }),
            ),
          ),
        ),
        // オーバーレイ：複数の GlassContainer を配置
        Positioned.fill(
          child: Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                GlassContainer(
                  width: 150,
                  height: 150,
                  blurAmount: 10.0,
                  glassThickness: 2.0,
                  refractiveIndex: 1.0,
                  opacity: 0.5,
                  borderRadius: BorderRadius.circular(20),
                  tintColor: Colors.blue,
                  enableRefraction: true,
                  child: Center(
                      child: Text('Glass 1',
                          style: TextStyle(color: Colors.white))),
                ),
                GlassContainer(
                  width: 150,
                  height: 150,
                  blurAmount: 15.0,
                  glassThickness: 3.0,
                  refractiveIndex: 1.2,
                  opacity: 0.6,
                  borderRadius: BorderRadius.circular(30),
                  tintColor: Colors.red,
                  enableRefraction: true,
                  child: Center(
                      child: Text('Glass 2',
                          style: TextStyle(color: Colors.white))),
                ),
                GlassContainer(
                  width: 150,
                  height: 150,
                  blurAmount: 8.0,
                  glassThickness: 1.5,
                  refractiveIndex: 1.0,
                  opacity: 0.4,
                  borderRadius: BorderRadius.circular(10),
                  tintColor: Colors.green,
                  enableRefraction: true,
                  child: Center(
                      child: Text('Glass 3',
                          style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EditModeScreen extends StatefulWidget {
  final double blurAmount;
  final double glassThickness;
  final double refractiveIndex;
  final double opacity;
  final BorderRadius borderRadius;
  final Color tintColor;
  final bool enableRefraction;
  final Function(double, double, double, double, BorderRadius, Color, bool)
  onParametersChanged;

  const EditModeScreen({
    Key? key,
    required this.blurAmount,
    required this.glassThickness,
    required this.refractiveIndex,
    required this.opacity,
    required this.borderRadius,
    required this.tintColor,
    required this.enableRefraction,
    required this.onParametersChanged,
  }) : super(key: key);

  @override
  _EditModeScreenState createState() => _EditModeScreenState();
}

class _EditModeScreenState extends State<EditModeScreen> {
  late double blurAmount;
  late double glassThickness;
  late double refractiveIndex;
  late double opacity;
  late BorderRadius borderRadius;
  late Color tintColor;
  late bool enableRefraction;

  @override
  void initState() {
    super.initState();
    blurAmount = widget.blurAmount;
    glassThickness = widget.glassThickness;
    refractiveIndex = widget.refractiveIndex;
    opacity = widget.opacity;
    borderRadius = widget.borderRadius;
    tintColor = widget.tintColor;
    enableRefraction = widget.enableRefraction;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: GlassContainer(
              width: 250,
              height: 250,
              blurAmount: blurAmount,
              glassThickness: glassThickness,
              refractiveIndex: refractiveIndex,
              opacity: opacity,
              borderRadius: borderRadius,
              tintColor: tintColor,
              enableRefraction: enableRefraction,
              child: Center(
                  child: Text('Edit Mode Glass',
                      style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
        // パラメータ調整用スライダーやボタン
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Blur Amount: ${blurAmount.toStringAsFixed(1)}'),
                Slider(
                  min: 0,
                  max: 30,
                  value: blurAmount,
                  onChanged: (value) {
                    setState(() {
                      blurAmount = value;
                      widget.onParametersChanged(
                          blurAmount,
                          glassThickness,
                          refractiveIndex,
                          opacity,
                          borderRadius,
                          tintColor,
                          enableRefraction);
                    });
                  },
                ),
                Text('Glass Thickness: ${glassThickness.toStringAsFixed(1)}'),
                Slider(
                  min: 0,
                  max: 10,
                  value: glassThickness,
                  onChanged: (value) {
                    setState(() {
                      glassThickness = value;
                      widget.onParametersChanged(
                          blurAmount,
                          glassThickness,
                          refractiveIndex,
                          opacity,
                          borderRadius,
                          tintColor,
                          enableRefraction);
                    });
                  },
                ),
                Text('Refractive Index: ${refractiveIndex.toStringAsFixed(1)}'),
                Slider(
                  min: 1,
                  max: 2,
                  value: refractiveIndex,
                  onChanged: (value) {
                    setState(() {
                      refractiveIndex = value;
                      widget.onParametersChanged(
                          blurAmount,
                          glassThickness,
                          refractiveIndex,
                          opacity,
                          borderRadius,
                          tintColor,
                          enableRefraction);
                    });
                  },
                ),
                Text('Opacity: ${opacity.toStringAsFixed(2)}'),
                Slider(
                  min: 0,
                  max: 1,
                  value: opacity,
                  onChanged: (value) {
                    setState(() {
                      opacity = value;
                      widget.onParametersChanged(
                          blurAmount,
                          glassThickness,
                          refractiveIndex,
                          opacity,
                          borderRadius,
                          tintColor,
                          enableRefraction);
                    });
                  },
                ),
                Text('Border Radius: ${borderRadius.topLeft.x.toStringAsFixed(1)}'),
                Slider(
                  min: 0,
                  max: 50,
                  value: borderRadius.topLeft.x,
                  onChanged: (value) {
                    setState(() {
                      borderRadius = BorderRadius.circular(value);
                      widget.onParametersChanged(
                          blurAmount,
                          glassThickness,
                          refractiveIndex,
                          opacity,
                          borderRadius,
                          tintColor,
                          enableRefraction);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tintColor = Colors.blue;
                          widget.onParametersChanged(
                              blurAmount,
                              glassThickness,
                              refractiveIndex,
                              opacity,
                              borderRadius,
                              tintColor,
                              enableRefraction);
                        });
                      },
                      child: Text('Blue'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tintColor = Colors.red;
                          widget.onParametersChanged(
                              blurAmount,
                              glassThickness,
                              refractiveIndex,
                              opacity,
                              borderRadius,
                              tintColor,
                              enableRefraction);
                        });
                      },
                      child: Text('Red'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tintColor = Colors.green;
                          widget.onParametersChanged(
                              blurAmount,
                              glassThickness,
                              refractiveIndex,
                              opacity,
                              borderRadius,
                              tintColor,
                              enableRefraction);
                        });
                      },
                      child: Text('Green'),
                    ),
                  ],
                ),
                // リフラクション効果の有効/無効を切り替えるスイッチ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enable Refraction'),
                    Switch(
                      value: enableRefraction,
                      onChanged: (value) {
                        setState(() {
                          enableRefraction = value;
                          widget.onParametersChanged(
                              blurAmount,
                              glassThickness,
                              refractiveIndex,
                              opacity,
                              borderRadius,
                              tintColor,
                              enableRefraction);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
