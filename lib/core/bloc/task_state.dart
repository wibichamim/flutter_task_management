part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

final class TaskInitial extends TaskState {}

final class LoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

final class LoadedState extends TaskState {
  final List<Task> allTask;
  const LoadedState(this.allTask);
  @override
  List<Object> get props => [allTask];
}

final class FailureState extends TaskState {
  final String errorMessage;
  const FailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class SuccessTaskInsert extends TaskState {
  @override
  List<Object?> get props => [];
}

final class SuccessTaskUpdate extends TaskState {
  @override
  List<Object?> get props => [];
}

final class SuccessTaskDelete extends TaskState {
  @override
  List<Object?> get props => [];
}
