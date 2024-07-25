import 'dart:convert';
import '../other/enums/urgency.dart';
import 'package:todo/src/models/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<List<Todo>> getAllTodoList() {
    List<List<Todo>> todoList = [];
    todoList.add(getTodo(Urgency.UI));
    todoList.add(getTodo(Urgency.UNI));
    todoList.add(getTodo(Urgency.NUI));
    todoList.add(getTodo(Urgency.NUNI));
    return todoList;
  }

  List<Todo> getTodo(Urgency urgency) {
    List<Todo> todoList = [];
    List<String> response = _prefs.getStringList(urgency.toString()) ?? [];
    for (int i = 0; i < response.length; i++) {
      var map = jsonDecode(response[i]);
      var todoItem = Todo.fromJson(map);
      todoList.add(todoItem);
    }
    return todoList;
  }

  List<Todo> getMenuPageTodo() {
    var response = _prefs.getStringList(Urgency.UI.toString());
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

  Future<bool> insertTodo(Todo todo, String severity) async {
    bool isDataEntered = false;

    switch (severity) {
      case 'UI':
        List<String> response =
            _prefs.getStringList(Urgency.UI.toString()) ?? [];
        if (response.isNotEmpty) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.UI.toString(), response);
        } else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.UI.toString(), list);
        }
        break;
      case 'UNI':
        List<String> response =
            _prefs.getStringList(Urgency.UNI.toString()) ?? [];
        if (response.isNotEmpty) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.UNI.toString(), response);
        } else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.UNI.toString(), list);
        }
        break;
      case 'NUI':
        var response = _prefs.getStringList('NUI');
        if (response != null) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUI.toString(), response);
        } else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.NUI.toString(), list);
        }
        break;
      case 'NUNI':
        var response = _prefs.getStringList('NUNI');
        if (response != null) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUNI.toString(), response);
        } else {
          List<String> list = [jsonEncode(todo.toJson())];
          isDataEntered =
              await _prefs.setStringList(Urgency.NUNI.toString(), list);
        }
        break;
    }
    return isDataEntered;
  }

  bool completeTask(int index, Urgency urgency) {
    try {
      List<String>? response = _prefs.getStringList(urgency.toString());
      if (response != null) {
        var map = jsonDecode(response[index]);
        var todoItem = Todo.fromJson(map);
        todoItem.isCompleted = true;
        response[index] = jsonEncode(todoItem);
        _prefs.setStringList(urgency.toString(), response);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  deleteTodo(int index, Urgency urgency) {
    try {
      List<String>? response = _prefs.getStringList(urgency.toString());
      if (response != null) {
        response.removeAt(index);
        _prefs.setStringList(urgency.toString(), response);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  updateTodo(String title, String description, Urgency urgency, String date,
      int index) {
    try {
      List<String>? response = _prefs.getStringList(urgency.toString());
      if (response != null) {
        Map<String, dynamic> map = jsonDecode(response[index]);
        Todo updateTodo = Todo.fromJson(map);
        updateTodo.title = title;
        updateTodo.description = description;
        updateTodo.complitionDate = date;
        response[index] = jsonEncode(updateTodo.toJson());
        _prefs.setStringList(urgency.toString(), response);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool revertTask(int index, Urgency urgency) {
    try {
      List<String>? response = _prefs.getStringList(urgency.toString());
      if (response != null) {
        var map = jsonDecode(response[index]);
        var todoItem = Todo.fromJson(map);
        todoItem.isCompleted = false;
        response[index] = jsonEncode(todoItem);
        _prefs.setStringList(urgency.toString(), response);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
