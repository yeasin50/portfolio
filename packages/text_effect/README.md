# Text Effect

Need some animation stuffs for my portfolio

`ParagraphData` to provide ParagraphData for render.
used to render textSpan for [AdvanceRichText] and [ParagraphPainter] text-effects.

- [`ParagraphPainter`](lib/src/paragraph_painter.dart) to have link hover line animation effect on richText/paragraph.
  Renders text as a paragraph, avoiding issues caused by WidgetSpan.
  WidgetSpan treats content as a separate chunk, which breaks word wrapping and forces words to move to the next line
  — an effect I want to avoid.

  - use `data` to style specific textSpan
  - `style` is the base TextStyle for the widget.
  - `hoverTextStyle` used for the link-text of data

  **Example**

  ```dart
    ParagraphPainter(
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
      ),
      hoverTextStyle: TextStyle(
        color: Colors.greenAccent,
        fontSize: 32,
      ),
      data: [
        ParagraphData(text: "Normal text"),
        ParagraphData(text: " hover effect for link", url: "asd"),
        ParagraphData(
            text: "  extra something.... "),
        ParagraphData(
            text: "I am bold with url",
            url: "asd",
            bold: true),
      ],
  )
  ```

  ***

- `CounterNumberEffect` , simple text counter scroll up animation

  - pass `children` or `value`, `startValue`

  ```dart
  CounterNumberEffect(
            value: 10,
            duration: Duration(seconds: 2),
          ),
  ```
