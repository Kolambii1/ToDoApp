import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'model/model.dart';

class ToDoController extends GetxController {
  final TextEditingController taskController = TextEditingController();
  RxList<Task> tasks = <Task>[].obs;
  RxList<Task> completedTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    var box = await Hive.openBox<Task>('tasks');
    tasks.value = box.values.toList();
  }

  void addTask(Task task) async {
    var box = await Hive.openBox<Task>('tasks');
    await box.add(task);
    loadTasks();
  }

  void completeTask(int index) async {
    var box = await Hive.openBox<Task>('tasks');
    Task completedTask = tasks[index];
    completedTask.isCompleted = true;
    completedTasks.add(completedTask);
    tasks.removeAt(index);
    await box.putAt(index, completedTask);
    await box.deleteAt(index);
    loadTasks();
  }
}
