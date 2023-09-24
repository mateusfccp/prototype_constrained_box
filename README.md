# prototype_constrained_box

[![Version](https://img.shields.io/pub/v/prototype_constrained_box)](https://pub.dev/packages/prototype_constrained_box)
[![License](https://img.shields.io/github/license/mateusfccp/prototype_constrained_box)](https://opensource.org/licenses/MIT)

## Features

* Just like [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html), you can constrain the `child` of this widget;
* However, instead of passing directly a [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html), you pass another `prototype` widget that will be used as constraint;
* You may constrain the `child` loosely or tightly, in one or both of the axes.

## Usage

Use the `PrototypeConstrainedBox` widget by providing a `prototype` and a `child`.

The following example will render a `ColoredBox` that will fill the space that the given `prototype` text would occupy:
```dart
const PrototypeConstrainedBox.tight(
  prototype: Text('Lorem ipsum dolor'),
  child: ColoredBox(
    color: Color(0xFFFF0000),
  ),
);
```

Aside from [`.tight`](https://pub.dev/documentation/prototype_constrained_box/latest/prototype_constrained_box/PrototypeConstrainedBox/PrototypeConstrainedBox.tight.html),
`PrototypeConstrainedBox` also provides [`.loose`](https://pub.dev/documentation/prototype_constrained_box/latest/prototype_constrained_box/PrototypeConstrainedBox/PrototypeConstrainedBox.loose.html),
[`.tightFor`](https://pub.dev/documentation/prototype_constrained_box/latest/prototype_constrained_box/PrototypeConstrainedBox/PrototypeConstrainedBox.tightFor.html) or you can completely customize the
constraints by using the [default unnamed constructor](https://pub.dev/documentation/prototype_constrained_box/latest/prototype_constrained_box/PrototypeConstrainedBox/PrototypeConstrainedBox.html).

For more information regarding the `PrototypeConstrainedBox` API, refer to [the documentation](https://pub.dev/documentation/prototype_constrained_box/latest/prototype_constrained_box/PrototypeConstrainedBox-class.html).
