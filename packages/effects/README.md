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

- increase scale on hover or tap

  ```dart
  eff.FocusView(
    child: SizedBox(
      height: 64,
      child: Text("title $index"),
    ),
  ),
  ```

- simple bullet point on hover, dot to circle with radial gradient
  TODO: add more effect type

  ```dart
  eff.BulletItemView(
    child: Text(
      "SomeText",
      style: textTheme.bodyLarge?.copyWith(color: textColor),
    ),
  )
  ```

- Animation Expansion tile with drop shader(FIXME: default `lowerBound`)

  ```dart
  eff.AnimatedExpansionTile(
    title: Text("Expansion title"),
    initialExpanded: true,
    lowerBound: .5,
    children: [
      for (final t in eff.BulletType.values)
        eff.BulletItemView(
          type: t,
          child: SizedBox(
            height: 64,
            child: Text(" ${t.name} "),
          ),
        ),
    ],
  ),
  ```

- animated Arrow create simple animated Arrow bullet point and next to the [child] as text
  /// TODO: need some work

  ```dart
  eff.AnimatedArrowView(
        child: DefaultTextStyle(
          style: theme.tldr.copyWith(color: Colors.black), //FIXME: use MergeTextStyle based on BG
          child: Text(
            "Available from $availableDate",
          ),
        ),
      );
  ```
