part of "list_task_bloc.dart";

abstract class ListTaskState extends Equatable {
  const ListTaskState();

  @override
  List<Object> get props => [];
}

class ListTaskInitialState extends ListTaskState {
  final List<TaskModel> tasks;

  const ListTaskInitialState({
    this.tasks = const [],
  });

  @override
  List<Object> get props => [
        tasks,
      ];
}
