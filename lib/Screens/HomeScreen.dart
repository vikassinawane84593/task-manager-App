import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Screens/add_task_screen.dart';
import 'package:task_manager_app/Screens/auth/login_Screen.dart';
import 'package:task_manager_app/Screens/edit_task.dart';
import 'package:task_manager_app/Servise/auth_service.dart';
import 'package:task_manager_app/Servise/task_services.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthService authService = AuthService();
    final TaskService taskService = TaskService();

    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Task Manager",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const LoginScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.red.shade700,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Manage your daily tasks easily",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Your Tasks",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: taskService.getTasks(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {

                    return Center(
                      child: Column(

                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.task_alt,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),

                          const SizedBox(height: 15),

                          Text(

                            "No Tasks Yet",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text("Tap + button to add tasks",

                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final tasks = snapshot.data!.docs;

                  return ListView.builder(

                    itemCount: tasks.length,

                    itemBuilder: (context, index) {

                      final task = tasks[index];

                      return  TaskTile(

                        title: task["title"],

                        description: task["description"],

                        date: task["date"],

                        onEdit: () {

                          TaskModel taskModel =
                          TaskModel(

                            id: task.id,

                            title: task["title"],

                            description:
                            task["description"],

                            date: task["date"],
                          );

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (context) =>
                                  EditTaskScreen(
                                    task: taskModel,
                                  ),
                            ),
                          );
                        },

                        onDelete: () async {

                          showDialog(

                            context: context,

                            builder: (context) {

                              return AlertDialog(

                                title: const Text(
                                  "Delete Task",
                                ),

                                content: const Text(
                                  "Are you sure you want to delete this task?",
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(context);
                                    },

                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  TextButton(

                                    onPressed: () async {

                                      await taskService
                                          .deleteTask(task.id);

                                      Navigator.pop(context);
                                    },

                                    child: const Text(
                                      "Delete",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton(

        backgroundColor: Colors.red.shade700,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const AddTaskScreen(),
            ),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}