import 'package:crackincode_test/core/model/task.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(bool?)? onCheckBoxClicked;
  final Function()? onTap;
  const TaskCard({
    super.key,
    required this.task,
    this.onCheckBoxClicked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 0.5, offset: Offset(0, 2))],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: task.isCompleted != 0,
                    onChanged: onCheckBoxClicked,
                  )
                ],
              ),
              const Gap(4),
              const Divider(),
              const Gap(4),
              Text(
                task.content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
