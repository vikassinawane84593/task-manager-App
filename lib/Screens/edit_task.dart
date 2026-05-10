import 'package:flutter/material.dart';
import 'package:task_manager_app/Servise/task_services.dart';
import 'package:task_manager_app/model/task_model.dart';

class EditTaskScreen extends StatefulWidget {

  final TaskModel task;

  const EditTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() =>
      _EditTaskScreenState();
}

class _EditTaskScreenState
    extends State<EditTaskScreen> {

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  final TaskService taskService = TaskService();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.task.title;

    descriptionController.text =
        widget.task.description;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,

              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: descriptionController,

              maxLines: 4,

              decoration: const InputDecoration(
                hintText: "Description",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () async {

                TaskModel updatedTask = TaskModel(

                  id: widget.task.id,

                  title:
                  titleController.text.trim(),

                  description:
                  descriptionController.text.trim(),

                  date: widget.task.date,
                );

                await taskService
                    .updateTask(updatedTask);

                Navigator.pop(context);
              },

              child: const Text(
                "Update Task",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}