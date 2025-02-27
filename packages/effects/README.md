# effects

A redesign basic widgets for solely for my usecase which will create conflict on naming.

## uses

import the package with a prefix

`import 'package:effects/effects.dart' as eff;`

- `NeonButton` a simple button with some effects. use `EffectThemeExt` to update the styles

  ```dart
    eff.NeonButton(
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

- `SphereView` radial gradient shadow based on mouse cursor

  ```dart
   eff.SphereView(
    key:ValueKey("yourKey")
    child: Padding(
      padding: const EdgeInsets.all(38.0),
      child: Text(
        "Hey",
        style: TextStyle(
          fontSize: 55,
        ),
      ),
    ),
  )
  ```

- Ripple page transition based [center], more like circle expanding

  ```dart
  final route = eff.RippleRoute(
    allowSnapshotting: true,
    center: FractionalOffset.center,
    popPosition: FractionalOffset.center,
    color: Colors.white,
    builder: (context) => Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: BackButton(),
      ),
    ),
  );

  Navigator.of(context).push(route);
  ```
