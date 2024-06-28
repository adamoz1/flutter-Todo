import 'package:get/get.dart';
import 'package:todo/src/pages/home/home.dart';

class Routes {
  final String homePage = "/";
  final String todoPage = "/todo";

  // This function return list of routes to the GetMaterialApp
  List<GetPage> getRoutes() {
    return [
      GetPage(name: homePage, page: () => const Home()),
      GetPage(name: todoPage, page: () => const Home()),
    ];
  }
}
