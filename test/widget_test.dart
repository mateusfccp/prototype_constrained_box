import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prototype_constrained_box/prototype_constrained_box.dart';

void main() {
  group('PrototypeConstrainedBox', () {
    group('.loose', () {
      testWidgets(
          'should prevent the child from being bigger than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.loose(
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size.square(64.0),
        );
      });

      testWidgets(
          'should allow the child from being smaller than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.loose(
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 32.0),
            );
          },
          expectation: const Size.square(32.0),
        );
      });

      testWidgets(
          'should not constrain the child when constrain is false',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.loose(
              constrain: false,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size.square(128.0),
        );
      });
    });

    group('.tight', () {
      testWidgets(
          'should prevent the child from being bigger than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tight(
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size.square(64.0),
        );
      });

      testWidgets(
          'should prevent the child from being smaller than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tight(
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 32.0),
            );
          },
          expectation: const Size.square(64.0),
        );
      });

      testWidgets(
          'should not constrain the child when constrain is false',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tight(
              constrain: false,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size.square(128.0),
        );
      });
    });

    group('.tightFor(width: true)', () {
      testWidgets(
          'should prevent the child from being wider than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tightFor(
              width: true,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size(64.0, 128.0),
        );
      });

      testWidgets(
          'should prevent the child from being narrower than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tightFor(
              width: true,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 32.0),
            );
          },
          expectation: const Size(64.0, 32.0),
        );
      });
    });

    group('.tightFor(height: true)', () {
      testWidgets(
          'should prevent the child from being taller than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tightFor(
              height: true,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 128.0),
            );
          },
          expectation: const Size(128.0, 64.0),
        );
      });

      testWidgets(
          'should prevent the child from being shorter than the prototype',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return PrototypeConstrainedBox.tightFor(
              height: true,
              prototype: const SizedBox.square(dimension: 64.0),
              child: SizedBox.square(key: key, dimension: 32.0),
            );
          },
          expectation: const Size(32.0, 64.0),
        );
      });
    });

    group('intrinsics', () {
      testWidgets(
          'should compute intrinsics before first layout inside IntrinsicWidth and IntrinsicHeight',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return IntrinsicWidth(
              child: IntrinsicHeight(
                child: PrototypeConstrainedBox.tight(
                  prototype: const SizedBox(width: 64.0, height: 48.0),
                  child: SizedBox(key: key, width: 128.0, height: 96.0),
                ),
              ),
            );
          },
          expectation: const Size(64.0, 48.0),
        );
      });

      testWidgets(
          'should compute intrinsics before first layout inside Table with IntrinsicColumnWidth',
          (WidgetTester tester) async {
        await _testWidget(
          tester: tester,
          builder: (key) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: [
                  TableRow(
                    children: [
                      PrototypeConstrainedBox.tight(
                        prototype: const SizedBox(width: 64.0, height: 48.0),
                        child: SizedBox(key: key, width: 128.0, height: 96.0),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          expectation: const Size(64.0, 48.0),
        );
      });

      testWidgets(
          'should constrain intrinsic height using prototype height rather than prototype width',
          (WidgetTester tester) async {
        final key = UniqueKey();
        await tester.pumpWidget(
          Center(
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: PrototypeConstrainedBox.loose(
                  key: key,
                  prototype: const SizedBox(width: 100.0, height: 50.0),
                  child: const SizedBox(width: 200.0, height: 80.0),
                ),
              ),
            ),
          ),
        );

        final renderBox = tester.renderObject<RenderBox>(find.byKey(key));
        expect(renderBox.getMinIntrinsicWidth(double.infinity), 100.0);
        expect(renderBox.getMaxIntrinsicWidth(double.infinity), 100.0);
        expect(renderBox.getMinIntrinsicHeight(double.infinity), 50.0);
        expect(renderBox.getMaxIntrinsicHeight(double.infinity), 50.0);
        expect(renderBox.size, const Size(100.0, 50.0));
      });

      testWidgets(
          'should apply min-only and unconstrained intrinsics accurately',
          (WidgetTester tester) async {
        final minKey = UniqueKey();
        final unconstrainedKey = UniqueKey();
        await tester.pumpWidget(
          Column(
            children: [
              IntrinsicWidth(
                child: IntrinsicHeight(
                  child: PrototypeConstrainedBox(
                    key: minKey,
                    constrainMinWidth: true,
                    constrainMinHeight: true,
                    prototype: const SizedBox(width: 100.0, height: 50.0),
                    child: const SizedBox(width: 40.0, height: 20.0),
                  ),
                ),
              ),
              IntrinsicWidth(
                child: IntrinsicHeight(
                  child: PrototypeConstrainedBox(
                    key: unconstrainedKey,
                    prototype: const SizedBox(width: 100.0, height: 50.0),
                    child: const SizedBox(width: 40.0, height: 20.0),
                  ),
                ),
              ),
            ],
          ),
        );

        final minBox = tester.renderObject<RenderBox>(find.byKey(minKey));
        expect(minBox.getMinIntrinsicWidth(double.infinity), 100.0);
        expect(minBox.getMaxIntrinsicWidth(double.infinity), 100.0);
        expect(minBox.getMinIntrinsicHeight(double.infinity), 50.0);
        expect(minBox.getMaxIntrinsicHeight(double.infinity), 50.0);
        expect(minBox.size, const Size(100.0, 50.0));

        final unconstrainedBox =
            tester.renderObject<RenderBox>(find.byKey(unconstrainedKey));
        expect(unconstrainedBox.getMinIntrinsicWidth(double.infinity), 40.0);
        expect(unconstrainedBox.getMaxIntrinsicWidth(double.infinity), 40.0);
        expect(unconstrainedBox.getMinIntrinsicHeight(double.infinity), 20.0);
        expect(unconstrainedBox.getMaxIntrinsicHeight(double.infinity), 20.0);
        expect(unconstrainedBox.size, const Size(40.0, 20.0));
      });
    });
  });
}

Future<void> _testWidget({
  required WidgetTester tester,
  required Widget Function(Key key) builder,
  required Size expectation,
}) async {
  final key = UniqueKey();
  await tester.pumpWidget(
    Center(child: builder(key)),
  );

  final renderBox = tester.renderObject<RenderBox>(find.byKey(key));

  expect(
    renderBox.size,
    expectation,
  );
}
