
// Taskモデル
// isDoneがint型なのはsqliteにboolian型がないから
class Task {
  int? id;
  String? todo;
  int? doneFlag;
  final DateTime? createdAt;
  DateTime? updatedAt;

  Task(
      this.id,
      this.todo,
      this.doneFlag,
      this.createdAt,
      this.updatedAt
      );
}