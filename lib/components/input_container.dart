import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  // const InputContainer({Key? key}) : super(key: key);
  bool validate = false;
  TextEditingController eCtrl = TextEditingController();
  final Function addList;

  InputContainer(this.validate, this.eCtrl, this.addList);

  @override
  Widget build(BuildContext context) {
    //こちらではインプットボックスの定義を行います。
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8.0))),
              child: TextField(
                //事前に宣言していたTextEditingController(eCtrl）をcontrollerに代入します。
                controller: eCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your task",
                  errorText: validate ? 'The input is empty.' : null,
                  contentPadding: EdgeInsets.all(8),
                ),
                onTap: () => validate = false,
                //Keyboardの官僚が押された際にアイテムを追加します。
                // 必要なければ省略しても構いません。
                onSubmitted: (text) {
                  //controllerが空のときに、addListItemの処理を行わないように分岐を書きます
                  if (text.isEmpty) {
                    validate = true;
                  } else {
                    addList(text);
                  }
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
              onPressed: () {
                //controllerが空のときに、addListItemの処理を行わないように分岐を書きます
                if (eCtrl.text.isEmpty) {
                  validate = true;
                } else {
                  addList(eCtrl.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
