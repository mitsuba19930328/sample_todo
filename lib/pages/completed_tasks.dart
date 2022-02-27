import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sample_todo/pages/app_background.dart';
import 'package:sample_todo/db/task.dart';

class CompletedTasks extends StatelessWidget {
  // const CompletedTasks({Key? key}) : super(key: key);
  List<Task> tasks = [];
  static const String _PageTitle = 'Completed Tasks';
  final Function deleteTask;

  CompletedTasks(
    this.tasks,
    this.deleteTask,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_PageTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          AppBackgroundPage(),

          //Columnを使用することで二つのWidgetを重ねるように配置します
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (tasks[i].status == 'true') {
                      return Column(
                        children: [
                          //ここに必要なリスト情報を渡す
                          buildListItem(tasks, i),
                        ],
                      );
                    } else {
                      return Column();
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static add(Task task) {}
}

Slidable buildListItem(List<Task> tasks, int i) {
  return Slidable(
    key: ObjectKey(tasks[i]),
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      // All actions are defined in the children parameter.
      children: const [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: null,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.replay,
          label: 'Taskへ戻す',
        ),
      ],
    ),
    // The end action pane is the one at the right or the bottom side.
    endActionPane: const ActionPane(
      motion: ScrollMotion(),
      dismissible: null,
      children: [
        SlidableAction(
          flex: 2,
          onPressed: null,
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: ListTile(
      subtitle: Text(tasks[i].completedDate.toString()),
      title: Text(
        tasks[i].title.toString(),
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
      leading: Icon(
        Icons.format_list_bulleted_rounded,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.check_box,
          color: Colors.greenAccent,
        ),
        onPressed: () {
          // TODO:ここにupdateTasksを入れる。
          null;
        },
      ),
    ),
  );
}
