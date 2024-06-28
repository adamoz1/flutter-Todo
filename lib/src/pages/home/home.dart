import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/commons/CusAppBar.dart';
import 'package:todo/src/pages/home/todoBox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todo = [];
  late TodoController controller;
  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDescription = TextEditingController();
  String severity = "UI";

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [const TodoBox(), menuList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  menuList() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          const CusAppBar(appbarTitle: "Home"),
          const Text(
            "Menu",
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
                // Here goes Grid View1
                ),
          )
        ],
      ),
    );
  }

  Future<void> initializeData() async {
    controller = Get.put(TodoController());
    controller.getAllList();
  }

  _addTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Todo"),
            content: Column(
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Todo Description"),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                    value: "UI",
                    items: const [
                      DropdownMenuItem(
                          value: "UI", child: Text("Urgent Important")),
                      DropdownMenuItem(
                          value: "UNI", child: Text("Urgent Not Important")),
                      DropdownMenuItem(
                          value: "NUI", child: Text("Not Urgent Important")),
                      DropdownMenuItem(
                          value: "NUNI",
                          child: Text("Not Urgent Not Important")),
                    ],
                    onChanged: (item) {
                      print("${item} is the type you selected");
                      severity = item ?? 'UI';
                    }),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    if (todoTitle.text.isNotEmpty &&
                        todoDescription.text.isNotEmpty) {
                      bool isDataEntered = await controller.insertTodo(
                          todoTitle.text, todoDescription.text, severity);
                      if (isDataEntered) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Todo Entered Successfully'),
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
        });
  }
}
