import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo/model/task.dart';

class TaskViewModel extends ChangeNotifier {
  String get editingMemo => memoController.text;
  TextEditingController memoController = TextEditingController();
  String _strValidateMemo = '';
  // String get strValidateName => _strValidateName;
  bool _validateMemo = false;
  // bool get validateName => _validateName;

  List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  // todoが書かれているかどうか判定
  bool validateTaskMemo() {
    if (memoController.text.isEmpty) {
      //選択されていない場合の処理を書く
      _strValidateMemo = 'Please input something';
      notifyListeners();
      return false;
    } else {
      //記載あった場合の処理を書く
      _strValidateMemo = '';
      _validateMemo = false;
      return true;
    }
  }

  // validateMemoの値書き換え
  void setValidateMemo(bool value) {
    _validateMemo = value;
  }

  // validateNameの値書き換え
  void updateValidateMemo() {
    if (_validateMemo) {
      // Memoが空でなければupdate処理
      validateTaskMemo();
      notifyListeners();
    }
  }

  void addTask() {
    // taskのadd処理
    DateTime date = new DateTime.now();
    final newTask = Task(
      memo: memoController.text,
      doneFlag: 0,
      createdAt: date,
      updatedAt: date,
    );
    _tasks.add(newTask);
    clear();
  }

  void updateTask() {
    // update処理
    // TODO 今は一旦未完成
    // var updateIndex = _tasks.indexWhere((task) {
    //   return task.createdAt == updateTask.createdAt;
    // });
    // updateTask.memo = memoController.text;
    // updateTask.updatedAt = DateTime.now();
    // _tasks[updateIndex] = updateTask;
    // clear();
    // notifyListeners();
  }

  void deleteTask(int index) {
    //taskの削除処理
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleDone(int index, int doneFlag) {
    var task = _tasks[index];
    task.doneFlag = doneFlag;
    _tasks[index] = task;
    notifyListeners();
  }

  void clear() {
    memoController.clear();
    _validateMemo = false;
    notifyListeners();
  }
}