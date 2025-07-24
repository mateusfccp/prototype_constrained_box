import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_constrained_box/prototype_constrained_box.dart';

void main() {
  runApp(const App());
}

final class App extends StatelessWidget {
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

final class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
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
                    prototype: const _SizedBoxPrototype(),
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
          const Expanded(
            child: Column(
              children: [
                _TextPrototype(),
                PrototypeConstrainedBox.tight(
                  prototype: _TextPrototype(),
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

final class _TextPrototype extends StatelessWidget {
  const _TextPrototype();

  @override
  Widget build(BuildContext context) {
    return const Text('Lorem ipsum dolor sit amet');
  }
}

final class _SizedBoxPrototype extends StatelessWidget {
  const _SizedBoxPrototype();

  @override
  Widget build(BuildContext context) => const SizedBox.square(dimension: 64.0);
}
