import 'package:crackincode_test/core/model/task.dart';
import 'package:crackincode_test/core/repositories/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Repository repository;
  TaskBloc(this.repository) : super(TaskInitial()) {
    on<GetAllTaskEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final task = await repository.getTask();
        emit(LoadedState(task));
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      emit(LoadingState());
      try {
        Future.delayed(const Duration(seconds: 1));
        int res = await repository.addTask(Task(
            title: event.task.title,
            content: event.task.content,
            isCompleted: event.task.isCompleted));

        if (res > 0) {
          emit(SuccessTaskInsert());
          add(GetAllTaskEvent());
        }
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        final task = await repository.updateTask(Task(
            id: event.task.id,
            title: event.task.title,
            content: event.task.content,
            isCompleted: event.task.isCompleted));

        if (task > 0) {
          emit(SuccessTaskUpdate());
          add(GetAllTaskEvent());
        }
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        final res = await repository.deleteTask(event.id);
        if (res > 0) {
          emit(SuccessTaskDelete());
          add(GetAllTaskEvent());
        }
      } catch (e) {
        emit(FailureState(e.toString()));
      }
    });
  }
}
