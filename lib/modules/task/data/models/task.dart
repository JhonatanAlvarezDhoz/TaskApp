import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late String title;

  String? description;

  @Index()
  late DateTime createdAt;

  @Index()
  DateTime? completedAt;

  late String status;

  Task({
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
  }) : assert(status == "pending" || status == "completed",
            'El estado debe ser "pending" o "completed"');

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "completedAt": completedAt?.toIso8601String(),
        "status": status,
      };

  // Método para crear un objeto Task desde JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    String status = json["status"];
    assert(status == "pending" || status == "completed",
        'El estado debe ser "pending" o "completed"');

    return Task(
      title: json["title"],
      description: json["description"],
      status: status,
      createdAt: DateTime.parse(json["createdAt"]),
      completedAt: json["completedAt"] != null
          ? DateTime.parse(json["completedAt"])
          : null,
    );
  }
}
