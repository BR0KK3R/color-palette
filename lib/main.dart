import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'colorTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Color Palette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color currentColor = Colors.blue;
  final nameController = TextEditingController();
  final hexController = TextEditingController();

  List<Widget> colorList = [];

  void _addColor() {
    Alert(
        buttons: [
          DialogButton(
            child: Text(
              'Add',
              style: TextStyle(),
            ),
            color: currentColor,
            onPressed: () {
              if (nameController.text.length > 0 &&
                  hexController.text.length == 7) {
                colorTile newColor = colorTile(
                  colorName: nameController.text,
                  colorHex: currentColor,
                  colorHexText: hexController.text,
                );
                setState(() {
                  colorList.add(newColor);
                });
                nameController.text = "";
                hexController.text = "";
                currentColor = Colors.blue;
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          )
        ],
        context: context,
        title: "New Color",
        content: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Color Name',
                  icon: Icon(
                    Icons.abc,
                    color: currentColor,
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: currentColor),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: currentColor))),
              cursorColor: currentColor,
            ),
            TextField(
              controller: hexController,
              decoration: InputDecoration(
                  hintText: '#ffffff',
                  icon: Icon(
                    Icons.color_lens,
                    color: currentColor,
                  ),
                  labelText: 'Color',
                  labelStyle: TextStyle(color: currentColor),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: currentColor))),
              cursorColor: currentColor,
              maxLength: 7,
              onChanged: (content) {
                if (hexController.text.length == 7) {
                  if (hexController.text[0] == "#") {
                    setState(() {
                      currentColor = Color(int.parse(
                              hexController.text.substring(1, 7),
                              radix: 16) +
                          0xFF000000);
                    });
                    Navigator.of(context, rootNavigator: true).pop();
                    _addColor();
                  }
                }
              },
            ),
          ],
        )).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: colorList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addColor,
        tooltip: 'Add new color',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
