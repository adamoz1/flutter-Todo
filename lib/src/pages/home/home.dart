import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/colors.dart';
import 'package:todo/src/other/enums/urgency.dart';
import 'package:todo/src/pages/home/todoBox.dart';
import 'package:todo/src/other/commons/CusAppBar.dart';
import 'package:todo/src/other/commons/cusDialog.dart';
import 'package:todo/src/pages/home/homeDashboard.dart';
import 'package:todo/src/controller/todoController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todo = [];
  RxString severity = "UI".obs;
  late TodoController controller;
  TextEditingController todoTitle = TextEditingController();
  TextEditingController complitionDate = TextEditingController();
  TextEditingController todoDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeData();
    complitionDate.text = DateTime.now().toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            todoTitleBlock(),
            const HomeDashboard(),
            TodoBox(
                list: controller.todoUIList,
                boxTitle: "Urgent Important List:",
                urgency: Urgency.UI),
            TodoBox(
              list: controller.todoUNIList,
              boxTitle: "Urgent Not Important List:",
              urgency: Urgency.UNI,
            ),
            TodoBox(
              list: controller.todoNUIList,
              boxTitle: "Not Urgent Important List:",
              urgency: Urgency.NUI,
            ),
            TodoBox(
              list: controller.todoNUNIList,
              boxTitle: "Not Urgent Not Important List:",
              urgency: Urgency.NUNI,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.black87,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }

  todoTitleBlock() {
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          CusAppBar(appbarTitle: "Home"),
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Future<void> initializeData() async {
    controller = Get.put(TodoController());
    controller.getAllList();
  }

  _addTodo() {
    CusDialog.showPopUpDialog(
      context,
      "Add Todo",
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
          Obx(() => DropdownButton(
              value: severity.value,
              items: const [
                DropdownMenuItem(value: "UI", child: Text("Urgent Important")),
                DropdownMenuItem(
                    value: "UNI", child: Text("Urgent Not Important")),
                DropdownMenuItem(
                    value: "NUI", child: Text("Not Urgent Important")),
                DropdownMenuItem(
                    value: "NUNI", child: Text("Not Urgent Not Important")),
              ],
              onChanged: (String? item) {
                print("${item} is the type you selected");
                severity.value = item ?? "UI";
              })),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: complitionDate,
            onTap: () async {
              try {
                print('Date Time before allocation ${complitionDate.text}');
                DateTime currentDate = DateTime.parse(complitionDate.text);
                var date = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day),
                    lastDate: DateTime(DateTime.now().year + 10));
                if (date != null) {
                  complitionDate.text = date.toString().substring(0, 10);
                  print(date.toString());
                  print(complitionDate.text);
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
                bool isDataEntered = await controller.insertTodo(todoTitle.text,
                    todoDescription.text, severity.value, complitionDate.text);
                if (isDataEntered) {
                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Todo Entered Successfully'),
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
                } else {
                  showDialog(
                      // ignore: use_build_context_synchronously
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
  }
}
