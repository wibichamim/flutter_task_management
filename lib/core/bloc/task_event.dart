part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetAllTaskEvent extends TaskEvent {
  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent(this.task);
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  const UpdateTaskEvent(this.task);
  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;
  const DeleteTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}
