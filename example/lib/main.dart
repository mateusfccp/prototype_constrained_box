import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_constrained_box/prototype_constrained_box.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    const prototype = _Prototype2();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PrototypeConstrainedBox'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PrototypeConstrainedBox.tight(
                    prototype: prototype,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox.square(
                          dimension: 16.0,
                          child: ColoredBox(
                            color: Color(
                              Random(index).nextInt(1 << 32),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: ColoredBox(
                    color: Colors.red,
                    child: SizedBox.square(dimension: 32.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: const [
                _Prototype(),
                PrototypeConstrainedBox.tight(
                  prototype: _Prototype(),
                  child: Placeholder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Prototype extends StatelessWidget {
  const _Prototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Text('Lorem ipsum dolor sit amet');
}

class _Prototype2 extends StatelessWidget {
  const _Prototype2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox.square(dimension: 64.0);
}
