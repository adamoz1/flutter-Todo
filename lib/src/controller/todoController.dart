import 'package:get/get.dart';
import 'package:todo/src/db/DBHelper.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/enums/urgency.dart';

class TodoController extends GetxController {
  RxList<Todo> todoUIList = RxList([]);
  RxList<Todo> todoUNIList = RxList([]);
  RxList<Todo> todoNUIList = RxList([]);
  RxList<Todo> todoNUNIList = RxList([]);
  RxInt completedTask = RxInt(0);
  RxInt pendingTask = RxInt(0);

  getDashboardDetail() {
    int totalCompletedTasks = 0;
    int totalInCompleteTasks = 0;
    print('Length of the list is ${todoUIList.length}');
    todoUIList.forEach((e) {
      print('is Completed ${e.isCompleted}');
      if (e.isCompleted == true) {
        totalCompletedTasks++;
      } else {
        totalInCompleteTasks++;
      }
    });
    todoUNIList.forEach((e) {
      if (e.isCompleted == true) {
        totalCompletedTasks++;
      } else {
        totalInCompleteTasks++;
      }
    });
    todoNUIList.forEach((e) {
      if (e.isCompleted == true) {
        totalCompletedTasks++;
      } else {
        totalInCompleteTasks++;
      }
    });
    todoNUNIList.forEach((e) {
      if (e.isCompleted == true) {
        totalCompletedTasks++;
      } else {
        totalInCompleteTasks++;
      }
    });
    print('$totalCompletedTasks, $totalInCompleteTasks  ');
    completedTask.value = totalCompletedTasks;
    pendingTask.value = totalInCompleteTasks;
  }

  void getAllList() {
    List<List<Todo>> allTodoList = DBHelper().getAllTodoList();
    todoUIList.value = allTodoList[0];
    todoUNIList.value = allTodoList[1];
    todoNUIList.value = allTodoList[2];
    todoNUNIList.value = allTodoList[3];
    update();
  }

  void getMenuPageTodo() {
    todoUIList.value = DBHelper().getMenuPageTodo();
  }

  Future<bool> insertTodo(
      String text, String text2, String severity, String date) async {
    Todo newTodo = Todo();
    newTodo.title = text;
    newTodo.description = text2;
    newTodo.isCompleted = false;
    newTodo.complitionDate = date;
    bool isDataEntered = await DBHelper().insertTodo(newTodo, severity);
    if (isDataEntered) {
      getAllList();
      getDashboardDetail();
    }
    return isDataEntered;
  }

  Future<bool> completeTask(int index, Urgency urgency) async {
    bool isTaskCompleted = await DBHelper().completeTask(index, urgency);
    if (isTaskCompleted) {
      getAllList();
      getDashboardDetail();
    }
    return isTaskCompleted;
  }

  deleteTask(int index, Urgency urgency) async {
    bool isTaskDeleted = await DBHelper().deleteTodo(index, urgency);
    if (isTaskDeleted) {
      getAllList();
      getDashboardDetail();
    }
    return isTaskDeleted;
  }

  updateTodo(String title, String description, Urgency urgency, String date,
      int index) async {
    bool isTodoUpdated =
        await DBHelper().updateTodo(title, description, urgency, date, index);
    if (isTodoUpdated) {
      getAllList();
      getDashboardDetail();
    }
    return isTodoUpdated;
  }

  revert(int index, Urgency urgency) async {
    bool isTaskReverted = await DBHelper().revertTask(index, urgency);
    if (isTaskReverted) {
      getAllList();
      getDashboardDetail();
    }
    return isTaskReverted;
  }
}
