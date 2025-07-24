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
