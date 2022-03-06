import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sample_todo/pages/app_background.dart';
import 'package:sample_todo/pages/list_page.dart';
import 'package:sample_todo/db/task.dart';

class CompletedTasks extends StatelessWidget {
  List<Task> _tasks = [];
  final Function deleteTask;
  final Function _updateItems;
  final Function createDateFormat;
  static const String _pageTitle = 'Completed Tasks';

  CompletedTasks(
    this._tasks,
    this.deleteTask,
    this._updateItems,
    this.createDateFormat,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(_pageTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          AppBackgroundPage(),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (_tasks[i].status == 'true') {
                      return Column(
                        children: [
                          //ここに必要なリスト情報を渡す
                          buildListItem(
                            _updateItems,
                            deleteTask,
                            _tasks,
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

  static add(Task task) {}
}

Slidable buildListItem(
  Function _updateItems,
  Function deleteTask,
  List<Task> _tasks,
  int i,
) {
  return Slidable(
    key: ObjectKey(_tasks[i]),
    startActionPane: ActionPane(
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: ((context) => {_updateItems(_tasks[i], i)}),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.replay,
          label: 'Taskへ戻す',
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: () {
        deleteTask(_tasks[i]);
      }),
      children: [
        SlidableAction(
          flex: 2,
          onPressed: ((context) => {deleteTask(_tasks[i])}),
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: ListTile(
      subtitle: Text(_tasks[i].completedDate.toString()),
      title: Text(
        _tasks[i].title.toString(),
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
        onPressed: () => {
          deleteTask(_tasks[i]),
        },
      ),
    ),
  );
}
