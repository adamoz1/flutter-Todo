import 'package:get/get.dart';
import 'package:todo/src/db/DBHelper.dart';
import 'package:todo/src/models/Todo.dart';

class TodoController extends GetxController {
  RxList<Todo> todoUIList = RxList([]);
  RxList<Todo> todoUNIList = RxList([]);
  RxList<Todo> todoNUIList = RxList([]);
  RxList<Todo> todoNUNIList = RxList([]);

  void getAllList() {
    print("Getx Controller is working");
    DBHelper().getMenuPageTodo();
  }

  Future<void> getMenuPageTodo() async {
    todoUIList.value = await DBHelper().getMenuPageTodo();
  }

  Future<bool> insertTodo(String text, String text2, String severity) async {
    Todo newTodo = Todo();
    newTodo.title = text;
    newTodo.description = text2;
    bool isDataEntered = await DBHelper().insertTodo(newTodo, severity);
    return isDataEntered;
  }
}
