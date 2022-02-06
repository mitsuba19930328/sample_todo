
// Taskモデル
// isDoneがint型なのはsqliteにboolian型がないから
class Task {
  int? id;
  String? memo;
  int? doneFlag;
  final DateTime? createdAt;
  DateTime? updatedAt;

  Task({
    this.id,
    this.memo,
    this.doneFlag,
    this.createdAt,
    this.updatedAt
  });
}