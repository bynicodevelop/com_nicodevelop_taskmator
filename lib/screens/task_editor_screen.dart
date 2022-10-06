import "package:com_nicodevelop_taskmator/config/constants.dart";
import "package:com_nicodevelop_taskmator/services/add_task/add_task_bloc.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({super.key});

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
        vertical: kDefaultPadding * 3,
      ),
      child: Wrap(
        children: [
          Text(
            "Que voulez-vous faire ?",
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding * 2,
            ),
            child: TextField(
              controller: _taskNameController,
              maxLines: 3,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: BlocListener<AddTaskBloc, AddTaskState>(
              listener: (context, state) {
                if (state is AddTaskSuccessState) {
                  Navigator.of(context).pop();
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  if (_taskNameController.text.isNotEmpty) {
                    context.read<AddTaskBloc>().add(
                          OnAddTaskEvent(
                            taskName: _taskNameController.text,
                          ),
                        );
                  }
                },
                child: const Text("Ajouter"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
