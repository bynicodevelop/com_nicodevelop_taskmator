part of "add_task_bloc.dart";

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class OnAddTaskEvent extends AddTaskEvent {
  final String taskName;

  const OnAddTaskEvent({
    required this.taskName,
  });

  @override
  List<Object> get props => [
        taskName,
      ];
}
