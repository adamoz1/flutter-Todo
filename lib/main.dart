import 'package:get/get.dart';
import 'package:todo/src/other/colors.dart';
import 'package:todo/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/db/DBHelper.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initializeDb();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes().getRoutes(),
      initialRoute: Routes().homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'JosefinSans',
          scaffoldBackgroundColor: white),
    );
  }
}
