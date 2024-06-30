import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/models/Todo.dart';
import '../other/enums/urgency.dart';

class DBHelper {
  DBHelper._privateConstructor();
  late SharedPreferences _prefs;
  static final DBHelper _instance = DBHelper._privateConstructor();

  factory DBHelper() {
    return _instance;
  }

  Future<void> initializeDb() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Todo> getTodos(String severity) {
    var response = _prefs.getStringList(severity);
    if (response == null) {
      return [];
    }
    List<Todo> todoList = [];
    for (int i = 0; i < response.length; i++) {
      var map = jsonDecode(response[i]);
      var todoItem = Todo.fromJson(map);
      todoList.add(todoItem);
    }
    return todoList;
  }

  Future<bool> insertTodo(Todo todo, Urgency severity) async {
    bool isDataEntered = false;

    switch (severity) {
      case Urgency.UI:
        print("Switch case is working while inserting data");
        List<String> response = _prefs.getStringList(Urgency.UI.toString()) ?? [];
        if (response.isNotEmpty) {
          print("UI has Data");
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.UI.toString(), response);
        } else {
          print("UI has no Data");
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.UI.toString(), list);
        }
        break;
      case Urgency.UNI:
        List<String> response = _prefs.getStringList(Urgency.UNI.toString()) ?? [];
        if (response.isNotEmpty) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.UNI.toString(), response);
        }else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.UNI.toString(), list);
        }
        break;
      case Urgency.NUI:
        List<String> response = _prefs.getStringList(Urgency.NUI.toString()) ?? [];
        if (response.isNotEmpty) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUI.toString(), response);
        } else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.NUI.toString(), list);
        }
        break;
      case Urgency.NUNI:
        List<String> response = _prefs.getStringList(Urgency.NUNI.toString()) ?? [];
        if (response.isNotEmpty) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUNI.toString(), response);
        } else{
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.NUNI.toString(), list);
        }
        break;
    }
    return isDataEntered;
  }

  Future<bool> updateTodo(Todo todo, Urgency severity, int index) async {
    List<String> response = _prefs.getStringList(severity.toString()) ?? [];
    response[index] = jsonEncode(todo.toJson());
    return _prefs.setStringList(severity.toString(), response);
  }

  Future<bool> completeTask(int index, Urgency severity){
    List<String> response = _prefs.getStringList(severity.toString()) ?? [];
    var map = jsonDecode(response[index]);
    var todoItem = Todo.fromJson(map);
    todoItem.isCompleted = true;
    response[index] = jsonEncode(todoItem.toJson());
    return _prefs.setStringList(severity.toString(), response);
  }

  Future<bool> deleteTask(int index, Urgency taskUrgency) {
    List<String> response = _prefs.getStringList(taskUrgency.toString()) ?? [];
    response.removeAt(index);
    return _prefs.setStringList(taskUrgency.toString(), response);
  }
}
