import "package:bloc/bloc.dart";
import "package:com_nicodevelop_taskmator/models/task_model.dart";
import "package:com_nicodevelop_taskmator/repositories/task_repository.dart";
import "package:equatable/equatable.dart";

part "list_task_event.dart";
part "list_task_state.dart";

class ListTaskBloc extends Bloc<ListTaskEvent, ListTaskState> {
  final TaskRepository taskRepository;

  ListTaskBloc({
    required this.taskRepository,
  }) : super(const ListTaskInitialState()) {
    on<OnListTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
