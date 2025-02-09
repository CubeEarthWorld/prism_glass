# prism_glass

[![pub package](https://img.shields.io/pub/v/prism_glass.svg)](https://pub.dev/packages/prism_glass)
[![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

`prism_glass`は、Flutterアプリケーションで簡単にグラスモーフィズム効果を実装できるパッケージです。ガラスのような透明感、ぼかし、屈折効果を持つコンテナを সহজেই作成できます。

## 特徴

*   **簡単な実装**: `GlassContainer`ウィジェットを使用するだけで、グラスモーフィズム効果を適用できます。
*   **カスタマイズ可能**: ぼかしの量、屈折率、透明度、角の丸みなど、さまざまなパラメータを調整して、 desired look and feel を実現できます。
*   **アニメーション**: パラメータの変更は、スムーズなアニメーションで反映されます。
*   **屈折効果**: 光の屈折をシミュレートすることで、よりリアルなガラスの表現が可能です(オプション)。
*   **グラデーション**: 背景や枠線にグラデーションを設定できます。
*   **ティントカラー**: ガラスの色合いを調整できます。

## インストール方法

`pubspec.yaml`ファイルに`prism_glass`をdependenciesとして追加します。

```yaml
dependencies:
  prism_glass: ^0.0.1 # バージョンは適宜変更してください
```

その後、ターミナルで以下のコマンドを実行します。

```bash
flutter pub get
```

## サンプルコード

```dart
import 'package:flutter/material.dart';
import 'package:prism_glass/prism_glass.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // 背景色を設定
      body: Center(
        child: GlassContainer(
          width: 300,
          height: 200,
          blurAmount: 10.0, // ぼかしの量 (最大値は10.0)
          refractiveIndex: 1.5, // 屈折率
          opacity: 0.7, // 透明度
          borderRadius: BorderRadius.circular(20), // 角の丸み
          // グラデーションを設定
          backgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.3), // 青色の透明度を調整
              Colors.green.withOpacity(0.2), // 緑色の透明度を調整
            ],
          ),
          // 枠線にグラデーションを設定
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.2),
            ],
          ),
          enableRefraction: true, // 屈折効果を有効にする
          child: Center(
            child: Text(
              'Hello, Glassmorphism!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // テキストの色を白に設定
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

このサンプルコードでは、`GlassContainer`を使って、背景がぼやけていて、光が屈折するガラスのようなコンテナを作成しています。`backgroundGradient`で背景にグラデーションを、`borderGradient`で枠線にグラデーションを設定しています。`enableRefraction`を`true`にすることで、屈折効果を有効にしています。`child`プロパティには、コンテナ内に表示するウィジェットを指定します。

## ライセンス

BSD 3-Clause License

Copyright (c) 2025, [Your Name]
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
2.  Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
3.  Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
