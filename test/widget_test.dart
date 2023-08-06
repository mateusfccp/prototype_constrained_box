import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prototype_constrained_box/prototype_constrained_box.dart';

void main() {
  group(
    'PrototypeConstrainedBox',
    () {
      group(
        '.loose',
        () {
          testWidgets(
            'should constrain the size of the child to the size of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.loose(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 128.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size.square(64.0),
              );
            },
          );

          testWidgets(
            'should allow the size of the child to be smaller than the size of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.loose(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 32.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size.square(32.0),
              );
            },
          );
        },
      );

      testWidgets(
        '.tight should force the child to have the same size as the prototype',
        (WidgetTester tester) async {
          final key = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tight(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key, dimension: 128.0),
              ),
            ),
          );

          final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

          expect(
            renderBox.size,
            const Size.square(64.0),
          );

          final key2 = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tight(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key2, dimension: 32.0),
              ),
            ),
          );

          final renderBox2 = tester.renderObject<RenderBox>(find.byKey(key2));

          expect(
            renderBox2.size,
            const Size.square(64.0),
          );
        },
      );

      group(
        '.looseHorizontal',
        () {
          testWidgets(
            'should constrain only the width of the child to the width of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.looseHorizontal(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 128.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size(64.0, 128.0),
              );
            },
          );

          testWidgets(
            'should allow the width of the child to be smaller than the width of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.looseHorizontal(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 32.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size(32.0, 32.0),
              );
            },
          );
        },
      );

      testWidgets(
        '.tightHorizontal should force the child to have the same width as the prototype',
        (WidgetTester tester) async {
          final key = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tightHorizontal(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key, dimension: 128.0),
              ),
            ),
          );

          final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

          expect(
            renderBox.size,
            const Size(64.0, 128.0),
          );

          final key2 = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tightHorizontal(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key2, dimension: 32.0),
              ),
            ),
          );

          final renderBox2 = tester.renderObject<RenderBox>(find.byKey(key2));

          expect(
            renderBox2.size,
            const Size(64.0, 32.0),
          );
        },
      );

      group(
        '.looseVertical',
        () {
          testWidgets(
            'should constrain only the height of the child to the height of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.looseVertical(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 128.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size(128.0, 64.0),
              );
            },
          );

          testWidgets(
            'should allow the height of the child to be smaller than the height of the prototype',
            (WidgetTester tester) async {
              final key = UniqueKey();
              await tester.pumpWidget(
                Center(
                  child: PrototypeConstrainedBox.looseVertical(
                    prototype: const SizedBox.square(dimension: 64.0),
                    child: SizedBox.square(key: key, dimension: 32.0),
                  ),
                ),
              );

              final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

              expect(
                renderBox.size,
                const Size(32.0, 32.0),
              );
            },
          );
        },
      );

      testWidgets(
        '.tightVertical should force the child to have the same height as the prototype',
        (WidgetTester tester) async {
          final key = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tightVertical(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key, dimension: 128.0),
              ),
            ),
          );

          final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

          expect(
            renderBox.size,
            const Size(128.0, 64.0),
          );

          final key2 = UniqueKey();
          await tester.pumpWidget(
            Center(
              child: PrototypeConstrainedBox.tightVertical(
                prototype: const SizedBox.square(dimension: 64.0),
                child: SizedBox.square(key: key2, dimension: 32.0),
              ),
            ),
          );

          final renderBox2 = tester.renderObject<RenderBox>(find.byKey(key2));

          expect(
            renderBox2.size,
            const Size(32.0, 64.0),
          );
        },
      );
    },
  );
}
