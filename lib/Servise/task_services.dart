import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_app/model/task_model.dart';

class TaskService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> addTask(TaskModel task) async {

    await firestore
        .collection("tasks")
        .doc(task.id)
        .set(task.toMap());
  }

  Future<void> deleteTask(String id) async {

    await firestore
        .collection("tasks")
        .doc(id)
        .delete();
  }

  Future<void> updateTask(TaskModel task) async {

    await firestore
        .collection("tasks")
        .doc(task.id)
        .update(task.toMap());
  }

  Stream<QuerySnapshot> getTasks() {

    return firestore
        .collection("tasks")
        .snapshots();
  }
}