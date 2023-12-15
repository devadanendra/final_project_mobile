import 'package:final_project_mobile/db/db_helper.dart';
import 'package:final_project_mobile/models/task.dart';
import 'package:get/get.dart';

// Kelas TaskController mengatur logika terkait tugas/data
class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs; // Variabel untuk menyimpan daftar tugas

  // Fungsi untuk menambahkan tugas ke database
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // Fungsi untuk mendapatkan daftar tugas dari database
  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // Fungsi untuk menghapus tugas dari database
  void delete(Task task) async {
    try {
      await DBHelper.delete(task);
      print("Task deleted successfully!");
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  // Fungsi untuk menandai tugas selesai di database
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTask(); // Memperbarui daftar tugas setelah pembaruan status
  }
}
