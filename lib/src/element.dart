import 'package:flutter/widgets.dart';

import 'rendering.dart';
import 'widget.dart';

class PrototypeConstrainedBoxElement extends RenderObjectElement {
  PrototypeConstrainedBoxElement(super.widget);

  Element? _prototype;
  Element? _child;

  static final _prototypeSlot = Object();
  static final _childSlot = Object();

  @override
  void visitChildren(ElementVisitor visitor) {
    final prototype = _prototype;
    if (prototype != null) {
      visitor(prototype);
    }

    final child = _child;
    if (child != null) {
      visitor(child);
    }
  }

  @override
  void forgetChild(Element child) {
    if (child == _child) {
      _child = null;
    } else if (child == _prototype) {
      _prototype = null;
    } else {
      assert(false);
    }
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final widget = this.widget as PrototypeConstrainedBox;
    _prototype = updateChild(_prototype, widget.prototype, _prototypeSlot);
    _child = updateChild(_child, widget.child, _childSlot);
  }

  @override
  void update(RenderObjectWidget newWidget) {
    super.update(newWidget);
    final widget = this.widget as PrototypeConstrainedBox;
    assert(widget == newWidget);
    _prototype = updateChild(_prototype, widget.prototype, _prototypeSlot);
    _child = updateChild(_child, widget.child, _childSlot);
  }

  @override
  void insertRenderObjectChild(RenderBox child, Object? slot) {
    final renderObject = this.renderObject as RenderPrototypeConstrainedBox;
    if (slot == _childSlot) {
      renderObject.child = child;
    } else if (slot == _prototypeSlot) {
      renderObject.prototype = child;
    }
  }

  @override
  void moveRenderObjectChild(RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    final renderObject = this.renderObject as RenderPrototypeConstrainedBox;
    if (slot == _childSlot) {
      assert(renderObject.child == child);
      renderObject.child = null;
    } else if (slot == _prototypeSlot) {
      assert(renderObject.prototype == child);
      renderObject.prototype = null;
    } else {
      assert(false);
    }
    assert(renderObject == this.renderObject);
  }
}
