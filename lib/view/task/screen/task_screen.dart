import 'dart:developer';

import 'package:crackincode_test/core/bloc/task_bloc.dart';
import 'package:crackincode_test/core/model/task.dart';
import 'package:crackincode_test/view/task/screen/add_task_screen.dart';
import 'package:crackincode_test/view/task/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Task Management APP'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  )),
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadedState) {
            inspect(state.allTask);
            return state.allTask.isEmpty
                ? const Center(child: Text('No Task'))
                : ListView.builder(
                    itemCount: state.allTask.length,
                    itemBuilder: (context, index) {
                      final task = state.allTask[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: TaskCard(
                          task: task,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTaskScreen(
                                task: task,
                              ),
                            ),
                          ),
                          onCheckBoxClicked: (_) => context
                              .read<TaskBloc>()
                              .add(
                                UpdateTaskEvent(
                                  Task(
                                    id: task.id,
                                    title: task.title,
                                    content: task.content,
                                    isCompleted: task.isCompleted == 0 ? 1 : 0,
                                  ),
                                ),
                              ),
                        ),
                      );
                    },
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
