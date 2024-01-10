import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/to_do_controller.dart';

import 'model/model.dart';

class ToDoList extends StatelessWidget {
  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: const Text(
          "To-Do List",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.taskController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Add a Task',
                labelStyle: const TextStyle(color: Colors.black),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.taskController.text.isNotEmpty) {
                      controller.addTask(Task(
                          title: controller.taskController.text,
                          isCompleted: false));
                      controller.taskController.clear();
                    }
                  },
                ),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  controller.addTask(Task(title: text, isCompleted: false));
                  controller.taskController.clear();
                }
              },
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            const Text(
              'Tasks',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.tasks[index];
                    return Card(
                      elevation: 3,
                      color: Colors.purple.shade300,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Checkbox(
                              value: task.isCompleted,
                              onChanged: (checked) {
                                if (checked != null) {
                                  controller.completeTask(index);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            const Text(
              'Completed Tasks',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.completedTasks[index];
                    return Card(
                      elevation: 3,
                      color: Colors.green.shade300,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(
                              Icons.check,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
