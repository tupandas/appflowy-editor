<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

<h1 align="center"><b>AppFlowy Editor</b></h1>

<p align="center">A highly customizable rich-text editor for Flutter</p>

<p align="center">
    <a href="https://discord.gg/ZCCYN4Anzq"><b>Discord</b></a> •
    <a href="https://twitter.com/appflowy"><b>Twitter</b></a>
</p>

<p align="center">
    <a href="https://codecov.io/github/AppFlowy-IO/appflowy-editor" >
        <img src="https://codecov.io/github/AppFlowy-IO/appflowy-editor/branch/main/graph/badge.svg?token=BXTGUXTWRU"/>
    </a>
</p>

<div align="center">
    <img src="https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/images/showcase.png?raw=true" width = "700" style = "padding: 100">
</div>

## Key Features

* Build rich, intuitive editors
* Design and modify an ever-expanding list of customizable features including
  * block components (such as form input controls, numbered lists, and rich text widgets)
  * shortcut events
  * themes
  * selection menu
  * toolbar menu
* [Test Coverage](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/testing.md) and ongoing maintenance by AppFlowy's core team and community of more than 1,000 builders

| Preview                | Customize your own theme   |
| ---------------------- | ------------------------   |
| ![Preview](documentation/images/preview.jpg) | ![Customize your own theme](documentation/images/theme.jpg) |

| Change the color of your text       | Format your text   |
| ---------------------- | ----------------------     |
| ![Color](documentation/images/color.jpg) | ![Format](documentation/images/format.jpg) |


## Getting Started

Add the AppFlowy editor [Flutter package](https://docs.flutter.dev/development/packages-and-plugins/using-packages) to your environment.

```shell
flutter pub add appflowy_editor
flutter pub get
```

## Creating Your First Editor

Start by creating a new empty AppFlowyEditor object.

```dart
final editorState = EditorState.blank(withInitialText: true); // with an empty paragraph
final editor = AppFlowyEditor(
  editorState: editorState,
);
```

You can also create an editor from a JSON object in order to configure your initial state. Or you can [create an editor from Markdown or Quill Delta](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/importing.md).

```dart
final json = jsonDecode('YOUR INPUT JSON STRING');
final editorState = EditorState(document: Document.fromJson(json));
final editor = AppFlowyEditor(
  editorState: editorState,
);
```

> Note: The parameters `localizationsDelegates` need to be assigned in MaterialApp widget
```dart
MaterialApp(
  localizationsDelegates: const [
    AppFlowyEditorLocalizations.delegate,
  ]，
);
```

To get a sense of how the AppFlowy Editor works, run our example:

```shell
git clone https://github.com/AppFlowy-IO/appflowy-editor.git
flutter pub get
flutter run
```

## Customizing Your Editor

### Customizing theme

Please refer to our documentation on customizing AppFlowy for a detailed discussion about [customizing theme](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/customizing.md#customizing-a-theme).

 * See further examples of [how AppFlowy custom the theme](https://github.com/AppFlowy-IO/AppFlowy/blob/main/frontend/appflowy_flutter/lib/plugins/document/presentation/editor_style.dart)

### Customizing Block Components

Please refer to our documentation on customizing AppFlowy for a detailed discussion about [customizing components](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/customizing.md#customize-a-component).

Below are some examples of component customizations:

 * [Todo List Block Component](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/lib/src/editor/block_component/todo_list_block_component/todo_list_block_component.dart) demonstrates how to extend new styles based on existing rich text components
 * [Divider Block Component](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/lib/src/editor/block_component/divider_block_component/divider_block_component.dart) demonstrates how to extend a new block component and render it
 * See further examples of [AppFlowy](https://github.com/AppFlowy-IO/AppFlowy/blob/main/frontend/appflowy_flutter/lib/plugins/document/presentation/editor_page.dart)

### Customizing Shortcut Events

Please refer to our documentation on customizing AppFlowy for a detailed discussion about [customizing shortcut events](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/customizing.md#customize-a-shortcut-event).

Below are some examples of shortcut event customizations:

 * [BIUS](https://github.com/AppFlowy-IO/appflowy-editor/tree/main/lib/src/editor/editor_component/service/shortcuts/character_shortcut_events/format_single_character) demonstrates how to make text bold/italic/underline/strikethrough through shortcut keys
 * Need more examples? Check out [shortcuts](https://github.com/AppFlowy-IO/appflowy-editor/tree/main/lib/src/editor/editor_component/service/shortcuts)

## Migration Guide
Please refer to the [migration documentation](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/documentation/UPGRADING.md).

## Glossary
Please refer to the API documentation.

## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

Please look at [CONTRIBUTING.md](https://appflowy.gitbook.io/docs/essential-documentation/contribute-to-appflowy/contributing-to-appflowy) for details.

## License
All code contributed to the AppFlowy Editor project is dual-licensed, and released under both of the following licenses:
1. The GNU Affero General Public License Version 3
2. The Mozilla Public License, Version 2.0 (the “MPL”)

See [LICENSE](https://github.com/AppFlowy-IO/appflowy-editor/blob/main/LICENSE) for more information.


---
__Advertisement :)__

- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
  resize in browser.
- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
  i18n with plurals support and easy syntax.

You will like those projects!

---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :cry: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++


### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==


### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.


### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

:   Definition 1
with lazy continuation.

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
*here be dragons*
:::


Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```


``` dart
 HighlightView(
  // The original code to be highlighted
  text.toPlainText(),

  // Specify language
  // It is recommended to give it a value for performance
  language: 'javascript',

  // Specify highlight theme
  // All available themes are listed in `themes` folder
  theme: githubTheme,

  // Specify padding
  padding: EdgeInsets.all(12),

  // Specify text style
  textStyle: TextStyle(
    fontSize: 16,
  ),
),
```

---
__Advertisement :)__

- __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
  resize in browser.
- __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
  i18n with plurals support and easy syntax.

You will like those projects!

---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading





## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```



## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :cry: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++


### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==


### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.


### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

:   Definition 1
with lazy continuation.

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
*here be dragons*
:::
