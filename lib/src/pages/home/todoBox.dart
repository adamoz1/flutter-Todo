// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/other/colors.dart';
import 'package:todo/src/other/commons/cusDialog.dart';
import 'package:todo/src/other/enums/urgency.dart';

class TodoBox extends StatefulWidget {
  final RxList list;
  final String boxTitle;
  final Urgency urgency;
  const TodoBox(
      {super.key,
      required this.list,
      required this.boxTitle,
      required this.urgency});

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  late String title;
  late RxList todoList;
  late Urgency _urgency;

  @override
  void initState() {
    super.initState();
    title = widget.boxTitle;
    todoList = widget.list;
    _urgency = widget.urgency;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(builder: (controller) {
      if (kDebugMode) {
        print("$title length is ${todoList.length}");
      }
      return todoList.isEmpty
          ? Container()
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(
                    color: black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: black, blurRadius: 3)]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, decoration: TextDecoration.underline),
                  ),
                  todoList.isEmpty
                      ? const Text('No Tasks entered!')
                      : _todoContainer(controller),
                ],
              ),
            );
    });
  }

  _todoContainer(TodoController controller) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      constraints: const BoxConstraints(maxHeight: 300),
      // height: 300,
      child: ListView.builder(
        itemCount: todoList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: todoList[index].isCompleted == true
                  ? completeTodo
                  : incompleteTodo,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  todoList[index].title ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(todoList[index].description ?? '',
                    style: const TextStyle(fontSize: 18)),
                Text(todoList[index].complitionDate ?? '',
                    style: const TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    todoList[index].isCompleted
                        ? Container(
                            decoration: BoxDecoration(
                                color: black87,
                                borderRadius: BorderRadius.circular(12)),
                            child:
                                _revertIconButton(context, controller, index),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: black87,
                                borderRadius: BorderRadius.circular(12)),
                            child:
                                _completeIconButton(context, controller, index),
                          ),
                    todoList[index].isCompleted
                        ? Container()
                        : const SizedBox(
                            width: 20,
                          ),
                    todoList[index].isCompleted
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                color: black87,
                                borderRadius: BorderRadius.circular(12)),
                            child: _editIconButton(context, controller, index),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: black87,
                          borderRadius: BorderRadius.circular(12)),
                      child: _deleteIconButton(context, controller, index),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _completeIconButton(
      BuildContext context, TodoController controller, int index) {
    return IconButton(
        onPressed: () {
          CusDialog.showPopUpDialog(context, "Confirmation",
              const Text("Are you sure to mark this todo completed"), [
            TextButton(
                onPressed: () async {
                  bool response =
                      await controller.completeTask(index, _urgency);
                  if (response) {
                    Navigator.pop(context);
                    CusDialog.showPopUpDialog(context, "Success",
                        const Text("Todo is marked completed"), [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ]);
                  } else {
                    CusDialog.showPopUpDialog(
                        context,
                        "Failure",
                        const Text(
                            "Due to some reason, todo can't be marked complete. Pls try again!!"),
                        [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"))
                        ]);
                  }
                },
                child: const Text("Ok")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ]);
        },
        icon: const Icon(
          Icons.check,
          color: white,
        ));
  }

  _revertIconButton(
      BuildContext context, TodoController controller, int index) {
    return IconButton(
        onPressed: () {
          CusDialog.showPopUpDialog(context, "Confirmation",
              const Text("Are you sure to revert this todo?"), [
            TextButton(
                onPressed: () async {
                  bool response = await controller.revert(index, _urgency);
                  if (response) {
                    Navigator.pop(context);
                    CusDialog.showPopUpDialog(context, "Success",
                        const Text("Todo is reverted successfully!!"), [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ]);
                  } else {
                    CusDialog.showPopUpDialog(
                        context,
                        "Failure",
                        const Text(
                            "Due to some reason, todo can't be reverted. Pls try again!!"),
                        [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"))
                        ]);
                  }
                },
                child: const Text("Ok")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ]);
        },
        icon: const Icon(
          Icons.replay_circle_filled_rounded,
          color: white,
        ));
  }

  _deleteIconButton(
      BuildContext context, TodoController controller, int index) {
    return IconButton(
        onPressed: () {
          CusDialog.showPopUpDialog(context, "Confirmation",
              const Text("Are you sure to delete this todo?"), [
            TextButton(
                onPressed: () async {
                  bool response = await controller.deleteTask(index, _urgency);
                  if (response) {
                    Navigator.pop(context);
                    CusDialog.showPopUpDialog(context, "Success",
                        const Text("Todo is delete Successfully"), [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ]);
                  } else {
                    CusDialog.showPopUpDialog(
                        context,
                        "Failure",
                        const Text(
                            "Due to some reason, todo can't be deleted. Pls try again!!"),
                        [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"))
                        ]);
                  }
                },
                child: const Text("Ok")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ]);
        },
        icon: const Icon(
          Icons.delete_rounded,
          color: white,
        ));
  }

  _editIconButton(BuildContext context, TodoController controller, int index) {
    TextEditingController todoTitle =
        TextEditingController(text: todoList[index].title);
    TextEditingController complitionDate =
        TextEditingController(text: todoList[index].complitionDate);
    TextEditingController todoDescription =
        TextEditingController(text: todoList[index].description);
    return IconButton(
      onPressed: () {
        CusDialog.showPopUpDialog(
          context,
          "Edit Todo",
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: todoTitle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Todo Title"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: todoDescription,
                maxLines: 3,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Todo Description"),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: complitionDate,
                onTap: () async {
                  try {
                    DateTime currentDate = DateTime.parse(complitionDate.text);
                    var date = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(DateTime.now().year + 10));
                    if (date != null) {
                      complitionDate.text = date.toString().substring(0, 10);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: 'Select Date', border: OutlineInputBorder()),
              )
            ],
          ),
          [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  if (todoTitle.text.isNotEmpty &&
                      todoDescription.text.isNotEmpty) {
                    bool isDataEntered = await controller.updateTodo(
                        todoTitle.text,
                        todoDescription.text,
                        _urgency,
                        complitionDate.text,
                        index);
                    if (isDataEntered) {
                      Navigator.pop(context);
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
                                    },
                                    child: const Text("Ok")),
                              ],
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Error in inserting Todo!!'),
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
                  }
                },
                child: const Text("Ok"))
          ],
        );
      },
      icon: const Icon(
        Icons.edit_rounded,
        color: white,
      ),
    );
  }
}
