import 'package:get/get.dart';
import 'package:todo/src/db/DBHelper.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:todo/src/other/enums/urgency.dart';

class TodoController extends GetxController {
  RxList<Todo> todoUIList = RxList([]);
  RxList<Todo> todoUNIList = RxList([]);
  RxList<Todo> todoNUIList = RxList([]);
  RxList<Todo> todoNUNIList = RxList([]);

  void getAllList(Urgency? urgency) {
    print("Getx Controller is working");
    if(urgency == null){
      List<Todo> uiList = DBHelper().getTodos(Urgency.UI.toString());
      List<Todo> uniList = DBHelper().getTodos(Urgency.UNI.toString());
      List<Todo> nuiList = DBHelper().getTodos(Urgency.NUI.toString());
      List<Todo> nuniList = DBHelper().getTodos(Urgency.NUNI.toString());
      todoUIList.assignAll(uiList);
      todoUNIList.assignAll(uniList);
      todoNUIList.assignAll(nuiList);
      todoNUNIList.assignAll(nuniList);
    } else {
      if(urgency == Urgency.UI) {
        List<Todo> uiList = DBHelper().getTodos(Urgency.UI.toString());
        todoUIList.assignAll(uiList);
      } else if(urgency == Urgency.UNI) {
        List<Todo> uniList = DBHelper().getTodos(Urgency.UNI.toString());
        todoUNIList.assignAll(uniList);
      } else if(urgency == Urgency.NUI) {
        List<Todo> nuiList = DBHelper().getTodos(Urgency.NUI.toString());
        todoNUIList.assignAll(nuiList);
      } else if(urgency == Urgency.NUNI) {
        List<Todo> nuniList = DBHelper().getTodos(Urgency.NUNI.toString());
        todoNUNIList.assignAll(nuniList);
      }
    }
  }

  Future<bool> insertTodo(String title, String description, Urgency severity) async {
    print("Inserting Todo is working in controller");
    Todo newTodo = Todo();
    newTodo.title = title;
    newTodo.description = description;
    newTodo.isCompleted = false;
    bool isDataEntered = await DBHelper().insertTodo(newTodo, severity);
    print("Data entered is $isDataEntered");
    if(isDataEntered) {
      if(severity == Urgency.UI) {
        getAllList(Urgency.UI);
      } else if(severity == Urgency.UNI) {
        getAllList(Urgency.UNI);
      } else if(severity == Urgency.NUI) {
        getAllList(Urgency.NUI);
      } else if(severity == Urgency.NUNI) {
        getAllList(Urgency.NUNI);
      }else{
        print("it is not same");
      }
    }
    return isDataEntered;
  }

  Future<bool> completeTask(int index, Urgency taskUrgency) async {
    bool isDataCompleted = await DBHelper().completeTask(index, taskUrgency);
    if(isDataCompleted) {
      if(taskUrgency == Urgency.UI) {
        getAllList(Urgency.UI);
      } else if(taskUrgency == Urgency.UNI) {
        getAllList(Urgency.UNI);
      } else if(taskUrgency == Urgency.NUI) {
        getAllList(Urgency.NUI);
      } else if(taskUrgency == Urgency.NUNI) {
        getAllList(Urgency.NUNI);
      }
    }
    return isDataCompleted;
  }

  Future<bool> updateTodo(String title, String description, int index, Urgency taskUrgency) async {
    Todo updatedTodo = Todo();
    updatedTodo.title = title;
    updatedTodo.description = description;
    bool isDataUpdated = await DBHelper().updateTodo(updatedTodo, taskUrgency, index);
    if(isDataUpdated) {
      if(taskUrgency == Urgency.UI) {
        getAllList(Urgency.UI);
      } else if(taskUrgency == Urgency.UNI) {
        getAllList(Urgency.UNI);
      } else if(taskUrgency == Urgency.NUI) {
        getAllList(Urgency.NUI);
      } else if(taskUrgency == Urgency.NUNI) {
        getAllList(Urgency.NUNI);
      }
    }
    return isDataUpdated;
  }

  Future<void> deleteTask(index, Urgency taskUrgency) async {
    bool isDataDeleted = await DBHelper().deleteTask(index, taskUrgency);
    if(isDataDeleted) {
      if(taskUrgency == Urgency.UI) {
        getAllList(Urgency.UI);
      } else if(taskUrgency == Urgency.UNI) {
        getAllList(Urgency.UNI);
      } else if(taskUrgency == Urgency.NUI) {
        getAllList(Urgency.NUI);
      } else if(taskUrgency == Urgency.NUNI) {
        getAllList(Urgency.NUNI);
      }
    }
  }
}
