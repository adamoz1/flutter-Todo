import 'package:get/get.dart';
import 'package:todo/src/pages/completedTodo/completedTodo.dart';
import 'package:todo/src/pages/home/home.dart';
import 'package:todo/src/pages/todoPage/todoPage.dart';

class Routes {
  final String homePage = "/";
  final String todoPage = "/todo";
  final String completedTodoPage = "/completedTodo";

  // This function return list of routes to the GetMaterialApp
  List<GetPage> getRoutes() {
    return [
      GetPage(name: homePage, page: () => const Home()),
      GetPage(name: todoPage, page: () => const TodoPage()),
      GetPage(name: completedTodoPage, page: () => const CompletedTodo()),
    ];
  }
}
