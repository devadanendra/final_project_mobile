import 'package:final_project_mobile/db/db_helper.dart';
import 'package:final_project_mobile/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) async {
    try {
      await DBHelper.delete(task);
      print("Task deleted successfully!");
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
