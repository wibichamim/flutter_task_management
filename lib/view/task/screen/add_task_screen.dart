import 'package:crackincode_test/core/bloc/task_bloc.dart';
import 'package:crackincode_test/core/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final title = TextEditingController(text: widget.task?.title);
    final content = TextEditingController(text: widget.task?.content);

    void deleteTask() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Task'),
            content: const Text("Are you sure wan't to delete this task ?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  context
                      .read<TaskBloc>()
                      .add(DeleteTaskEvent(widget.task?.id ?? 0));
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is SuccessTaskUpdate ||
            state is SuccessTaskInsert ||
            state is SuccessTaskDelete) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.task == null ? "Add Task" : "Update Task"),
            actions: [
              Visibility(
                visible: widget.task != null,
                child: IconButton(
                  onPressed: () => deleteTask(),
                  icon: const Icon(Icons.delete),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(hintText: "Title"),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title Can't Empty";
                        }
                        return null;
                      },
                    ),
                    const Gap(8),
                    TextFormField(
                      controller: content,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 10,
                      decoration: const InputDecoration(
                        hintText: "Content",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Content Can't Empty";
                        }
                        return null;
                      },
                    ),
                    const Gap(12),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<TaskBloc>().add(
                                widget.task == null
                                    ? AddTaskEvent(
                                        Task(
                                          title: title.value.text,
                                          content: content.value.text,
                                        ),
                                      )
                                    : UpdateTaskEvent(
                                        Task(
                                          id: widget.task?.id,
                                          title: title.value.text,
                                          content: content.value.text,
                                          isCompleted: widget.task?.isCompleted,
                                        ),
                                      ),
                              );
                        }
                      },
                      child: Text(widget.task == null ? 'Submit' : 'Update'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
