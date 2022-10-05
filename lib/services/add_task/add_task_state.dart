part of "add_task_bloc.dart";

abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitialState extends AddTaskState {}

class AddTaskLoadingState extends AddTaskState {}

class AddTaskSuccessState extends AddTaskState {}

class AddTaskFailureState extends AddTaskState {
  final String code;

  const AddTaskFailureState({
    required this.code,
  });

  @override
  List<Object> get props => [
        code,
      ];
}
