import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/other/commons/CusAppBar.dart';
import 'package:todo/src/other/enums/urgency.dart';
import 'package:todo/src/pages/todoPage/todoList.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDescription = TextEditingController();
  Urgency severity = Urgency.UI;
  TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CusAppBar(appbarTitle: "Todo Page"),
            SizedBox(height: 30,),
            // _todoHeading("Urgent Important"),
            TodoList(urgency: "UI"),
            TodoList(urgency: "UNI",),
            TodoList(urgency: "NUI",),
            TodoList(urgency: "NUNI",),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
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
                    value: Urgency.UI,
                    items: const [
                      DropdownMenuItem(
                          value: Urgency.UI, child: Text("Urgent Important")),
                      DropdownMenuItem(
                          value: Urgency.UNI, child: Text("Urgent Not Important")),
                      DropdownMenuItem(
                          value: Urgency.NUI, child: Text("Not Urgent Important")),
                      DropdownMenuItem(
                          value: Urgency.NUNI,
                          child: Text("Not Urgent Not Important")),
                    ],
                    onChanged: (item) {
                      print("${item} is the type you selected");
                      severity = item ?? Urgency.UI;
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
                                        todoTitle.clear();
                                        todoDescription.clear();
                                        Navigator.pop(context);
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

  // _todoHeading(heading){
  //   return Text(heading, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),);
  // }
}