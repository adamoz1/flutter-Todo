import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/enums/urgency.dart';

class CompletedTodoList extends StatefulWidget {
  final String urgency;
  const CompletedTodoList({super.key,required this.urgency});

  @override
  State<CompletedTodoList> createState() => _CompletedTodoListState();
}

class _CompletedTodoListState extends State<CompletedTodoList> {
  late String title;
  late RxInt count;
  late RxList<Todo> taskList;
  late Urgency taskUrgency;
  TodoController controller = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 45, left: 16, right: 16),
      child: Obx(() {
        switch (widget.urgency) {
          case "UI":
            title = "Urgent Important";
            taskUrgency = Urgency.UI;
            taskList = controller.todoUIList;
            count = controller.todoUIList.length.obs;
            break;
          case "UNI":
            title = "Urgent Not Important";
            taskUrgency = Urgency.UNI;
            taskList = controller.todoUNIList;
            count = controller.todoUNIList.length.obs;
            break;
          case "NUI":
            title = "Not Urgent Important";
            taskUrgency = Urgency.NUI;
            taskList = controller.todoNUIList;
            count = controller.todoNUIList.length.obs;
            break;
          case "NUNI":
            title = "Not Urgent Not Important";
            taskUrgency = Urgency.NUNI;
            taskList = controller.todoNUNIList;
            count = controller.todoNUNIList.length.obs;
            break;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(),
            ),
            _getDisplayList()
          ],
        );
      }),
    );
  }

  _getDisplayList() {
    int isThereAnyTask = 0;
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].isCompleted == true) {
        isThereAnyTask++;
        break;
      }
    }
    return isThereAnyTask == 0
        ? const Text("No todo's 😊")
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return taskList[index].isCompleted == true ? Container() : SlideInLeft(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 250),
                delay: Duration(milliseconds: 100 * index),
                child: FadeIn(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            taskList[index].title ?? "Error",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            taskList[index].description ?? "Error",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  _deleteTodo(index, taskList[index].title);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  void _deleteTodo(int index, String? todo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete todo"),
            content:
                Text("Are you sure you want to fulfill this task?  [$todo]"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteTask(index, taskUrgency);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }
}