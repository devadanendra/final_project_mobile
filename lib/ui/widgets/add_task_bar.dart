// ignore_for_file: deprecated_member_use, unused_element

import 'package:final_project_mobile/controllers/task_controller.dart';
import 'package:final_project_mobile/models/task.dart';
import 'package:final_project_mobile/ui/theme.dart';
import 'package:final_project_mobile/ui/widgets/button.dart';
import 'package:final_project_mobile/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Halaman 'Add Task' digunakan untuk menambahkan tugas baru ke dalam aplikasi
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30 PM";
  String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now())
      .toString(); // Memformat waktu awal jadi String
  //Membuat List yang berisi data remind
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  //Membuat List yang berisi data repeat
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context), // Tampilan App Bar
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task", // Judul halaman
                style: headingStyle,
              ),
              MyInputField(
                title: "Title", // Label untuk judul tugas
                hint: "Enter your title", // Petunjuk input
                controller: _titleController, // Controller untuk judul
              ),
              MyInputField(
                title: "Note", // Label untuk catatan
                hint: "Enter your note", // Petunjuk input
                controller: _noteController, // Controller untuk catatan
              ),
              // Input field untuk memilih tanggal
              MyInputField(
                title: "Date", // Label untuk tanggal
                hint: DateFormat.yMd()
                    .format(_selectedDate), // Tampilan tanggal terpilih
                widget: IconButton(
                  onPressed: () {
                    print("Hi There");
                    _getDateFromUser(); // Fungsi untuk memilih tanggal
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined, // Icon kalender
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  // Input field untuk memilih waktu mulai
                  Expanded(
                    child: MyInputField(
                      title: "Start Date", // Label untuk waktu mulai
                      hint: _startTime, // Tampilan waktu mulai terpilih
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(
                              isStartTime:
                                  true); // Fungsi untuk memilih waktu mulai
                        },
                        icon: Icon(
                          Icons.access_time_rounded, // Icon jam
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  // Input field untuk memilih waktu selesai
                  Expanded(
                    child: MyInputField(
                      title: "End Date", // Label untuk waktu selesai
                      hint: _endTime, // Tampilan waktu selesai terpilih
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(
                              isStartTime:
                                  false); // Fungsi untuk memilih waktu selesai
                        },
                        icon: Icon(
                          Icons.access_time_rounded, // Icon jam
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Dropdown untuk memilih remind
              MyInputField(
                title: "Remind", // Label untuk remind
                hint:
                    "$_selectedRemind minutes early", // Tampilan remind terpilih
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down, // Icon panah ke bawah
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                ),
              ),
              // Dropdown untuk memilih repeat
              MyInputField(
                title: "Repeat", // Label untuk repeat
                hint: "$_selectedRepeat", // Tampilan repeat terpilih
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down, // Icon panah ke bawah
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value!, style: TextStyle(color: Colors.grey)));
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(), // Palet warna berdasarkan method
                  MyButton(
                      label: "Create Task",
                      onTap: () =>
                          _validateDate()) // Tombol untuk membuat tugas
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasktoDb(); // Validasi dan tambahkan tugas ke dalam database

      Get.back(); // Kembali ke halaman sebelumnya
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
          "Perhatian", "Wajib di-isi ya!", // Pesan jika ada input yang kosong
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded)); // Icon peringatan
    }
  }

  // Menambahkan tugas ke dalam database
  _addTasktoDb() async {
    // Menyimpan nilai yang dikembalikan saat menambahkan tugas ke database
    int value = await _taskController.addTask(
      task: Task(
        // Mengambil nilai dari controller untuk catatan dan judul tugas
        note: _noteController.text,
        title: _titleController.text,
        // Mengambil tanggal yang dipilih dalam format yang diinginkan
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime, // Menggunakan waktu mulai yang telah dipilih
        endTime: _endTime, // Menggunakan waktu selesai yang telah dipilih
        remind: _selectedRemind, // Menggunakan pengingat yang telah dipilih
        repeat: _selectedRepeat, // Menggunakan pengulangan yang telah dipilih
        color: _selectedColor, // Menggunakan warna yang telah dipilih
        isCompleted: 0, // Menandakan bahwa tugas belum selesai
      ),
    );
    // Menampilkan ID tugas yang baru ditambahkan
    print("My ID is " + "$value");
  }

// Widget untuk palet warna
  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color", // Judul palet warna
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        // Membuat palet warna dengan pilihan untuk memilih warna
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index; // Mengubah warna yang dipilih
                  print("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr // Warna primer
                      : index == 1
                          ? pinkClr // Warna pink
                          : yellowClr, // Warna kuning
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done, // Icon tanda centang jika warna dipilih
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

// Widget AppBar yang menampilkan navigasi dan tindakan lainnya
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back(); // Kembali ke halaman sebelumnya
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
            backgroundImage: AssetImage("images/user.png")), // Avatar pengguna
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

// Mengambil input dari pengguna untuk tanggal
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate; // Memperbarui tanggal yang dipilih
        print(_selectedDate);
      });
    } else {
      print("Something is wrong"); // Pesan jika terjadi kesalahan
    }
  }

// Mengambil input waktu dari pengguna (waktu mulai/waktu selesai)
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled"); // Pesan jika pembatalan waktu
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime; // Memperbarui waktu mulai
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime; // Memperbarui waktu selesai
      });
    }
  }

  _showTimePicker() {
    // Mengambil waktu yang sudah dipilih tanpa format tambahan
    String formattedStartTime = _startTime
        .replaceAll(".", "")
        .replaceAll("PM", "")
        .replaceAll("AM", "");
    // Membagi waktu menjadi komponen jam dan menit
    List<String> timeComponents = formattedStartTime.split(":");

    int hour =
        int.parse(timeComponents[0]); // Menetapkan jam dari waktu yang dipilih
    int minute = int.parse(timeComponents[1]
        .trim()
        .split(" ")[0]); // Menetapkan menit dari waktu yang dipilih

    // Menyesuaikan jam untuk waktu PM (jika diperlukan)
    if (_startTime.contains("PM") && hour != 12) {
      hour += 12;
    }

    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: hour, // Menetapkan jam awal
        minute: minute, // Menetapkan menit awal
      ),
    );
  }
}
