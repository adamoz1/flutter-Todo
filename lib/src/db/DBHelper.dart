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

  void getTodos() {}

  Future<List<Todo>> getMenuPageTodo() async {
    var response = _prefs.getStringList(Urgency.UI.toString());
    if (response == null) {
      print("There is not data in the database");
      return [];
    }
    List<Todo> todoList = [];
    for (int i = 0; i < response.length; i++) {
      var map = jsonDecode(response[i]);
      var todoItem = Todo.fromJson(map);
      todoList.add(todoItem);
    }
    print(
        "${todoList} is the data in the model and the length is ${todoList.length}");
    return todoList;
  }

  Future<bool> insertTodo(Todo todo, severity) async {
    bool isDataEntered = false;

    switch (severity) {
      case 'UI':
        print("Switch case is working");
        List<String> response = _prefs.getStringList('UI') ?? [];
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
        var response = _prefs.getStringList('UNI');
        if (response != null) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.UNI.toString(), response);
        }
        break;
      case 'NUI':
        var response = _prefs.getStringList('NUI');
        if (response != null) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUI.toString(), response);
        }
        break;
      case 'NUNI':
        var response = _prefs.getStringList('NUNI');
        if (response != null) {
          response.add(jsonEncode(todo.toJson()));
          isDataEntered =
              await _prefs.setStringList(Urgency.NUNI.toString(), response);
        }
        break;
    }
    return isDataEntered;
  }
}
