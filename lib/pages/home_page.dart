import 'package:flutter/material.dart';
import 'package:flutter_annotation/components/global.dart';
import 'package:flutter_annotation/libraries/todo/todo.dart';
import 'package:my_mark/my_mark.dart';

@Mark(name: "hello")
class MarkDemo { }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyListView(
        children: [
          MyButton(
            onPressed: () {
              _doSomething();
            },
            text: 'Hello',
          )
        ],
      ),
    );
  }

  @Todo('seth', 'make this do something')
  void _doSomething() {
    _show('do something');
  }

  _show(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
