# effects

A redesign basic widgets for solely for my usecase which will create conflict on naming.

## uses

import the package with a prefix

`import 'package:effects/effects.dart' as eff;`

- `NeonButton` a simple button with some effects. use `EffectThemeExt` to update the styles

  ```dart
    NeonButton(
        label: "See more",
        onTap: () {...},
    )
  ```

- `FilterChip` a simple child with a check label

  ```dart
  eff.FilterChip(
  label: "Tab $i",
  isActive: selectedItem.contains(i),
  activeColor: Colors.blue.withAlpha(100),
  inActiveColor: Colors.grey.withAlpha(100),
  onTap: () {
    selectedItem.contains(i)
        ? selectedItem.remove(i)
        : selectedItem.add(i);
    setState(() {});
  },
  ),
  ```
