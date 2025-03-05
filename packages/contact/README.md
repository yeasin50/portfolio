# Contact and Connect section

The way/Reason of contract; Goal is to reduce the time consumption for both parties by exposing information.

## Sections

Theses should be passed from parent from `IConnectRepo` implementation class for me.

- [ ] Hire process summary
- [ ] For scholarship reason
- [ ] Open Source contribution
- [ ] Bug Hunting
- [ ] Story/Discussion

## info

- [ ] things I use
- [ ] limitation
- [ ] preference
- [ ] working schedule
- [ ] history
- [ ] usual yearly weekend/holidays to ensure remote work nature
  - [ ] `ramadan` timing
  - [ ] Eid specific
  - [ ] December

## TODO

- [ ] Infrastructure documentation
- [ ] Format and limit export
- [ ] Remove unused snippets

## Use

1. import the package

   ```yaml
   contact:
     path: ../../packages/contact
   ```

2. Provide the theme, you can have your custom one

   ```dart
    MaterialApp(
        theme: ThemeData.dark().copyWith(
        extensions: [ ContactThemeExt.darkTheme() ],
    ),)
   ```

3. Also page required dataRepo, implement `IConnectRepo` class.
