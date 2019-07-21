import 'package:cell_input/cell_input.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _groupValue = "密码";
  InputType _inputType = InputType.password;

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        appBar: AppBar(
          title: Text("验证码输入框"),
        ),
        body: Column(
          children: <Widget>[
            CellInput(
              key: UniqueKey(),
              autofocus: true,
              inputType: _inputType,

            ),
            RadioListTile<String>(
                value: '密码',
                title: Text('密码'),
                groupValue: _groupValue,
                onChanged: (v) {
                  setState(() {
                    _inputType = InputType.password;
                    _groupValue = v;
                  });
                }),
            RadioListTile<String>(
                value: '数字',
                groupValue: _groupValue,
                title: Text('数字'),
                onChanged: (v) {
                  setState(() {
                    _inputType = InputType.number;
                    _groupValue = v;
                  });
                }),
            RadioListTile<String>(
                value: '文本',
                groupValue: _groupValue,
                title: Text('文本'),
                onChanged: (v) {
                  setState(() {
                    _inputType = InputType.text;
                    _groupValue = v;
                  });
                }),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
