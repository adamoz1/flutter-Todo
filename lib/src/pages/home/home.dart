import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/commons/CusAppBar.dart';
import 'package:todo/src/other/enums/urgency.dart';
import 'package:todo/src/pages/home/todoBox.dart';
import 'package:todo/src/routes.dart';

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
  Urgency severity = Urgency.UI;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CusAppBar(appbarTitle: "Home"),
            const SizedBox(
              height: 16,
            ),
            const TodoBox(),
            menuList()
          ],
        ),
      ),
    );
  }

  menuList() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Menu",
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  menuContainer("Todo List", Icons.today_outlined, Routes().todoPage),
                  menuContainer("Completed Todo", Icons.check_box, Routes().completedTodoPage),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell menuContainer(title, icon, route) {
    return InkWell(
      onTap: (){Get.toNamed(route);},
      child: Container(
        decoration: BoxDecoration(
        color: Colors.black87,borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initializeData() async {
    controller = Get.put(TodoController());
    controller.getAllList(null);
  }
}
