import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/other/commons/CusAppBar.dart';
import 'package:todo/src/other/enums/urgency.dart';
import 'package:todo/src/pages/completedTodo/completedTodoList.dart';

class CompletedTodo extends StatefulWidget {
  const CompletedTodo({super.key});

  @override
  State<CompletedTodo> createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
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
            CusAppBar(appbarTitle: "Completed Todo Page"),
            SizedBox(height: 30,),
            CompletedTodoList(urgency: "UI"),
            CompletedTodoList(urgency: "UNI",),
            CompletedTodoList(urgency: "NUI",),
            CompletedTodoList(urgency: "NUNI",),
          ],
        ),
      ),
    );
  }
}