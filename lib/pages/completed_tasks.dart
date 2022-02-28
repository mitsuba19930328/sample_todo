import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sample_todo/pages/app_background.dart';
import 'package:sample_todo/pages/list_page.dart';
import 'package:sample_todo/db/task.dart';

class CompletedTasks extends StatefulWidget {
  // const CompletedTasks({Key? key}) : super(key: key);
  List<Task> tasks = [];
  static const String _PageTitle = 'Completed Tasks';
  final Function deleteTask;
  final Function _updateItems;
  final Function createDateFormat;

  CompletedTasks(
    this.tasks,
    this.deleteTask,
    this._updateItems,
    this.createDateFormat,
  );

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();

  static add(Task task) {}
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(CompletedTasks._PageTitle),
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
                  itemCount: widget.tasks.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (widget.tasks[i].status == 'true') {
                      return Column(
                        children: [
                          //ここに必要なリスト情報を渡す
                          buildListItem(
                            widget._updateItems,
                            widget.deleteTask,
                            widget.tasks,
                            i,
                          ),
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
}

Slidable buildListItem(
  Function _updateItems,
  Function deleteTask,
  List<Task> tasks,
  int i,
) {
  return Slidable(
    key: ObjectKey(tasks[i]),
    startActionPane: ActionPane(
      motion: ScrollMotion(),
      // All actions are defined in the children parameter.
      children: [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (context) => _updateItems(tasks[i], i),
          // onPressed: (context) => _updateItems(tasks[i], i),
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
        // onPressed: () => null,
        onPressed: () => deleteTask(tasks[i]),
      ),
    ),
  );
}
