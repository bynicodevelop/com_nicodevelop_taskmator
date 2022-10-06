part of "list_task_bloc.dart";

abstract class ListTaskEvent extends Equatable {
  const ListTaskEvent();

  @override
  List<Object> get props => [];
}

class OnListTaskEvent extends ListTaskEvent {}
