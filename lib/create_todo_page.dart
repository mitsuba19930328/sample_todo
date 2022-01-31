import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  var _todoController = TextEditingController();
  var _text = '';
  final myFocusNode = FocusNode();

  void _submit() {
      // 入力内容
      _text = _todoController.text;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo新規作成"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text('todo: '),
                ),
                Expanded(
                  flex: 14,
                  child: TextFormField(
                    controller: _todoController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'todoに追加したい内容を入力',
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('追加'),
              onPressed: (){
                _submit();
              },
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(_text),
            )
          ],
        ),
      ),
    );
  }
}
