
import 'package:get/get.dart';
import 'package:univy_mobile/db/db_helper.dart';
import 'package:univy_mobile/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList =<Task>[].obs;

  Future<int>addTask({Task?task})async
  {
return await DBHelper.intset(task);
  }

  // get all the data from table
  void getTasks() async {
    print("getTasks function getTasks");
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new  Task.fromJson(data)).toList());

    print(tasks);
  }
void delete(Task task)
{
DBHelper.delete(task);
getTasks();

}

 void markTaskCompleted(int id)async
 {
   await DBHelper.update(id);
   getTasks();
 }


}
