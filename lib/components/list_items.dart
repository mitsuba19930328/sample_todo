import 'package:flutter/material.dart';
import 'package:sample_todo/db/task.dart';

class ListItems extends StatelessWidget {
  // const ListItems({Key? key}) : super(key: key);
  final List<Task> tasks;
  ListItems(this.tasks);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //ここに必要なリスト情報を渡す
      ],
    );
  }
}
