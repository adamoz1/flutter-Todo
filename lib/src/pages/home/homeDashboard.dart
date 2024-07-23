import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controller/todoController.dart';
import 'package:todo/src/other/colors.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  late TodoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    controller.getDashboardDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => _dashboardCard(
                'Completed Tasks', controller.completedTask.value.toString())),
            Obx(() => _dashboardCard(
                'Incompleted Tasks', controller.pendingTask.value.toString()))
          ],
        ),
        Row(
          children: [
            Obx(() => _dashboardCard('Ratio of Completion',
                '${controller.completedTask.value}:${controller.completedTask.value + controller.pendingTask.value}'))
          ],
        )
      ],
    );
  }

  _dashboardCard(heading, text) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: black87,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(15),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 22, color: white),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: white),
          ),
        ],
      )),
    ));
  }
}
