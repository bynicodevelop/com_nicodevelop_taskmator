import "package:bloc/bloc.dart";
import "package:com_nicodevelop_taskmator/exceptions/standard_exception.dart";
import "package:com_nicodevelop_taskmator/repositories/task_repository.dart";
import "package:equatable/equatable.dart";

part "add_task_event.dart";
part "add_task_state.dart";

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskRepository taskRepository;

  AddTaskBloc({
    required this.taskRepository,
  }) : super(AddTaskInitialState()) {
    on<OnAddTaskEvent>((event, emit) async {
      emit(AddTaskLoadingState());

      try {
        await taskRepository.create({
          "taskName": event.taskName,
        });

        emit(AddTaskSuccessState());
      } on StandardException catch (e) {
        emit(AddTaskFailureState(
          code: e.code,
        ));
      }
    });
  }
}
