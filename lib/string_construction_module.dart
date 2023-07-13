import 'package:flutter/material.dart';

class StringConstructionModule extends StatefulWidget {
  @override
  _StringConstructionModuleState createState() =>
      _StringConstructionModuleState();
}

class _StringConstructionModuleState extends State<StringConstructionModule> {
  final TextEditingController textEditingController = TextEditingController();
  String constructedString = '';

  final List<String> variables = [
    'variable1',
    'variable2',
    'variable3',
  ];

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void updateConstructedString() {
    setState(() {
      constructedString = textEditingController.text;
    });
  }

  void addVariable(String variable) {
    final int cursorPosition = textEditingController.selection.baseOffset;
    final String originalText = textEditingController.text;
    final String textBeforeCursor = originalText.substring(0, cursorPosition);
    final String textAfterCursor = originalText.substring(cursorPosition);
    final String updatedText = '$textBeforeCursor$variable$textAfterCursor';
    textEditingController.text = updatedText;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition + variable.length));
    updateConstructedString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textEditingController,
          // onChanged: (_) => updateConstructedString(),
          decoration: InputDecoration(
            labelText: 'Enter Text',
          ),
          onChanged: (text) {
            final int cursorPosition =
                textEditingController.selection.baseOffset;
            final String typedCharacter =
                text.substring(cursorPosition - 1, cursorPosition);
            if (typedCharacter == '@') {
              showVariablesMenu(context);
            }
          },
        ),
        SizedBox(height: 16),
        Text('Constructed String: $constructedString'),
      ],
    );
  }

  void showVariablesMenu(BuildContext context) {
    final RenderBox textFieldRenderBox =
        context.findRenderObject() as RenderBox;
    final Offset textFieldOffset =
        textFieldRenderBox.localToGlobal(Offset.zero);

    final List<PopupMenuEntry<String>> popupItems = variables.map((variable) {
      return PopupMenuItem<String>(
        value: variable,
        child: Text(variable),
      );
    }).toList();

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        textFieldOffset.dx,
        textFieldOffset.dy + textFieldRenderBox.size.height,
        textFieldOffset.dx + textFieldRenderBox.size.width,
        textFieldOffset.dy + textFieldRenderBox.size.height + 10.0,
      ),
      items: popupItems,
    ).then((selectedValue) {
      if (selectedValue != null) {
        addVariable(selectedValue);
      }
    });
  }
}

// Usage:
// StringConstructionModule()  // Add this widget to your Flutter app's UI hierarchy
