import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/enums/urgency.dart';

class TodoList extends StatefulWidget {
  final String urgency;
  const TodoList({super.key, required this.urgency});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late String title;
  late RxList<Todo> taskList;
  late Urgency taskUrgency;
  TodoController controller = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
  }

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
            break;
          case "UNI":
            title = "Urgent Not Important";
            taskUrgency = Urgency.UNI;
            taskList = controller.todoUNIList;
            break;
          case "NUI":
            title = "Not Urgent Important";
            taskUrgency = Urgency.NUI;
            taskList = controller.todoNUIList;
            break;
          case "NUNI":
            title = "Not Urgent Not Important";
            taskUrgency = Urgency.NUNI;
            taskList = controller.todoNUNIList;
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
      if (taskList[i].isCompleted == false) {
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
                                icon: const Icon(Icons.edit),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  _updateTask(taskList[index].title,
                                      taskList[index].description, index);
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.check),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  _fulfillTask(index, taskList[index].title);
                                },
                              ),
                              const SizedBox(width: 8),
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

  void _fulfillTask(int index, String? task) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Fulfill Task"),
            content:
                Text("Are you sure you want to fulfill this task?  [$task]"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  controller.completeTask(index, taskUrgency);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
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

  void _updateTask(String? title, String? description, int index) {
    TextEditingController updateTitle = TextEditingController(text: title);
    TextEditingController updateDescription =
        TextEditingController(text: description);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: updateTitle,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Task Title"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: updateDescription,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Task Description"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  bool isDataUpdated = await controller.updateTodo(
                      updateTitle.text,
                      updateDescription.text,
                      index,
                      taskUrgency);
                  if (isDataUpdated) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Todo Updated Successfully'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok")),
                            ],
                          );
                        });
                  }else{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Todo Update Failed'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok")),
                            ],
                          );
                        });
                  }
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }
}
