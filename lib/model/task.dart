
// Taskモデル
// isDoneがint型なのはsqliteにboolian型がないから
class Task {
  int? id;
  String? status;
  String? title;
  String? addedDate;
  String? completedDate;

  Task({
    this.id,
    this.status,
    this.title,
    this.addedDate,
    this.completedDate,
  });
}