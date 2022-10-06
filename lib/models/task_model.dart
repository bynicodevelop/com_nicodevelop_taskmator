import "package:equatable/equatable.dart";

class TaskModel extends Equatable {
  final String id;
  final String name;

  const TaskModel({
    required this.id,
    required this.name,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data) => TaskModel(
        id: data["id"],
        name: data["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  TaskModel copyWith({
    String? id,
    String? name,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
