//list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sample_todo/components/input_container.dart';
import 'package:sample_todo/pages/completed_tasks.dart';
import 'package:sample_todo/db/task.dart';
import 'package:sample_todo/pages/app_background.dart';
// import 'package:sample_todo/pages/completed_task_page.dart';

var listPageKey = GlobalKey<_ListPageState>();

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool validate = false;
  List<Task> tasks = [];

  final TextEditingController eCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }

  //現在時刻をフォーマット化するための関数を定義
  String createDateFormat(DateTime now) {
    var formatter = DateFormat('yyyy/MM/dd/HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  //　Validateの後に行われる処理
  // Listに新しいTaskが追加される処理です。
  void addListItem(String text) {
    validate = false;
    final Task newItem = Task(
        title: text,
        status: 'false',
        addedDate: createDateFormat(DateTime.now()),
        completedDate: '');
    // SetStateを行うことによってWidgetの内容を更新
    setState(() {
      //tasksの0番目に新しいタスクを追加
      tasks.insert(0, newItem);
    });
    // Controllerの内容を消去する
    eCtrl.clear();
  }

  //　Taskのアップデートを行う処理
  void updateItems(Task task, int i) {
    if (task.status == 'false') {
      final updatedTask = Task(
          title: task.title,
          status: 'true',
          addedDate: task.addedDate,
          completedDate: createDateFormat(DateTime.now()));
      //tasksのi番目のタスクを新しいタスクと入れ替える。
      tasks[i] = updatedTask;
    } else if (task.status == 'true') {
      final updatedTask = Task(
          title: task.title,
          status: 'false',
          addedDate: task.addedDate,
          completedDate: '');
      tasks[i] = updatedTask;
    }
    setState(() {});
  }

  //タスクの削除を行う処理
  void removeListItem(Task task) async {
    setState(() => tasks.remove(task));
  }

  //通ってるかチェック
  void checkRun(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Tasks'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompletedTasks(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        //Stackを使用することによってZ軸上にWidgetを重ねることができます。
        body: Stack(
          children: <Widget>[
            AppBackgroundPage(),

            //Columnを使用することで二つのWidgetを重ねるように配置します
            Column(
              children: <Widget>[
                InputContainer(validate, eCtrl, addListItem),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (tasks[i].status == 'false') {
                        checkRun('通ってる12');
                      }
                      return buildListItem(tasks, i);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//List itemの定義
  Slidable buildListItem(List<Task> tasks, int i) {
    return Slidable(
      key: ObjectKey(tasks[i]),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          removeListItem(tasks[i]);
        }),

        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          // SlidableAction(
          //   // An action can be bigger than the others.
          //   flex: 2,
          //   onPressed: null,
          //   backgroundColor: Color(0xFF7BC043),
          //   foregroundColor: Colors.white,
          //   icon: Icons.archive,
          //   label: 'Archive',
          // ),
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
        subtitle: tasks[i].status == 'false'
            ? Text(tasks[i].addedDate.toString())
            : Text(tasks[i].completedDate.toString()),
        title: Text(
          tasks[i].title.toString(),
          style: TextStyle(
              color: tasks[i].status == 'false' ? Colors.black : Colors.grey,
              decoration: tasks[i].status == 'false'
                  ? TextDecoration.none
                  : TextDecoration.lineThrough),
        ),
        leading: Icon(Icons.list),
        trailing: IconButton(
          icon: Icon(
            (tasks[i].status == 'false')
                ? Icons.check_box_outline_blank
                : Icons.check_box,
            color: Colors.greenAccent,
          ),
          onPressed: () {
            updateItems(tasks[i], i);
          },
        ),
      ),
    );
    // return Dismissible(
    //   key: ObjectKey(tasks[i]),
    //   //Slidableを使うことによってwidgetを左右にスライドすることが可能になります。
    //   onDismissed: (direction) {
    //     checkRun('通ってるよ');
    //     removeListItem(tasks[i]);
    //     setState(() {
    //       // updateItems(tasks[i], i);
    //     });
    //   },
    //   child: Slidable(
    //     endActionPane: ActionPane(
    //       extentRatio: 0.50,
    //       motion: ScrollMotion(),
    //       children: [],
    //     ),
    //     // actionPane: SlidableDrawerActionPane(),
    //     child: Column(
    //       children: <Widget>[
    //         ListTile(
    //           subtitle: tasks[i].status == 'false'
    //               ? Text(tasks[i].addedDate.toString())
    //               : Text(tasks[i].completedDate.toString()),
    //           title: Text(
    //             tasks[i].title.toString(),
    //             style: TextStyle(
    //                 color:
    //                     tasks[i].status == 'false' ? Colors.black : Colors.grey,
    //                 decoration: tasks[i].status == 'false'
    //                     ? TextDecoration.none
    //                     : TextDecoration.lineThrough),
    //           ),
    //           leading: Icon(Icons.list),
    //           trailing: IconButton(
    //             icon: Icon(
    //               (tasks[i].status == 'false')
    //                   ? Icons.check_box_outline_blank
    //                   : Icons.check_box,
    //               color: Colors.greenAccent,
    //             ),
    //             onPressed: () {
    //               updateItems(tasks[i], i);
    //             },
    //           ),
    //         ),
    //         Divider(height: 0)
    //       ],
    //     ),
    //     //右にスライドした際に行う処理をここに書きます。
    //     // 今回はチェックとアンチェックを行う処理をここで行います。
    //     // actions: <Widget>[
    //     //   tasks[i].status == 'false'
    //     //       ? IconSlideAction(
    //     //           caption: 'Complete',
    //     //           color: Colors.greenAccent,
    //     //           icon: Icons.check,
    //     //           onTap: () {
    //     //             updateItems(tasks[i], i);
    //     //           },
    //     //         )
    //     //       : IconSlideAction(
    //     //           caption: 'Undo',
    //     //           color: Colors.grey,
    //     //           icon: Icons.check,
    //     //           onTap: () {
    //     //             updateItems(tasks[i], i);
    //     //           },
    //     //         )
    //     // ],
    //     //右にスライドした際に行う処理をここに書きます。
    //     // 今回は削除を行う処理をここで行います。
    //     // secondaryActions: <Widget>[
    //     //   IconSlideAction(
    //     //     caption: 'Delete',
    //     //     color: Colors.red,
    //     //     icon: Icons.delete,
    //     //     onTap: () {
    //     //       removeListItem(tasks[i]);
    //     //     },
    //     //   )
    //     // ],
    //   ),
    // );
  }
}
