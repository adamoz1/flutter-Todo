import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/controller/todoController.dart';

class TodoBox extends StatefulWidget {
  const TodoBox({super.key});

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  TodoController controller = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16), child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Obx(()=>Column(
          mainAxisSize: MainAxisSize.min,
          children: todoList(),
        ),)
      ),
    ));
  }

  List<Widget> todoList(){
    List<Widget> list = [];
    if(controller.todoUIList.isNotEmpty){
      int count = 0;
        for(int i = 0; i < controller.todoUIList.length; i++){
          if(count == 5){
            break;
          }
          if(controller.todoUIList[i].isCompleted == true){
            continue;
          }else{
            count++;
          }
          list.add(
            ListTile(
              leading: Text(count.toString(),style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              title: Text(controller.todoUIList[i].title??"",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
              subtitle: Text(controller.todoUIList[i].description??"",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
            )
          );
        }
    }
    print(list);
    if(list.isEmpty){
      list.add(
        const Center(
          child: Text("No UI todos"),
        )
      );
    }
    
    list = [const Text("Urgent Important Todos",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),),...list];
    return list;
  }
}
