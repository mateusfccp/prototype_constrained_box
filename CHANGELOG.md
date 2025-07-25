## 2.0.3+1

* Format code and update lint dependencies

## 2.0.3

* Fix exception when selecting the widget in Flutter Inspector (#3)
* Dependencies updated

## 2.0.2

* Fix exception when trying to read debug properties in Flutter Inspector (#1)

## 2.0.1

* `PrototypeConstrainedBox` unnamed constructor now has default values for `constrain*` parameters
  * All `constrain` parameters default to `false`

## 2.0.0+1

* Improved documentation

## 2.0.0

* **BREAKING:** `PrototypeConstrainedBoxElement` is now private
* **BREAKING:** `ConstraintType` has been removed from the API
* **BREAKING:** `PrototypeConstrainedBox` is now a `final class`, and thus can't be extended/implemented anymore
* **BREAKING:** `PrototypeConstrainedBox` API has been changed to be more similar to what we have in `BoxConstraints`
  * `PrototypeConstrainedBox.looseHorizontal` and `PrototypeConstrainedBox.looseVertical` constructors have been removed
  * `PrototypeConstrainedBox.tightHorizontal` and `PrototypeConstrainedBox.tightVertical` have been replaced by `PrototypeConstrainedBox.tightFor`
  * `PrototypeConstrainedBox` default unnamed constructor allows for complete customization of constraints, allowing constraints that were not possible before
* **Fix:** `RenderPrototypeConstrainedBox` was not calling `super` on `redepthChildren`
* Now, instead of laying out `prototype`, we compute it's constraints by using `getDryLayout`

## 1.0.0

* Added tests
* Improved example

## 0.0.1+1

* Updated documentation

## 0.0.1

* Initial commit
