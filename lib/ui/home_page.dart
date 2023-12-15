// ignore_for_file: deprecated_member_use

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_project_mobile/controllers/task_controller.dart';
import 'package:final_project_mobile/models/task.dart';
import 'package:final_project_mobile/services/theme_services.dart';
import 'package:final_project_mobile/ui/theme.dart';
import 'package:final_project_mobile/ui/widgets/add_task_bar.dart';
import 'package:final_project_mobile/ui/widgets/button.dart';
import 'package:final_project_mobile/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// Kelas untuk mengatur state dari halaman utama
class _HomePageState extends State<HomePage> {
  DateTime _selectedDate =
      DateTime.now(); // Variabel untuk menyimpan tanggal yang dipilih
  final _taskController =
      Get.put(TaskController()); // Controller untuk manajemen tugas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(), // Menampilkan app bar sesuai fungsi _appBar()
      backgroundColor: context
          .theme.backgroundColor, // Mengatur warna latar belakang sesuai tema

      // Membangun tampilan dengan susunan widget-column
      body: Column(
        children: [
          _addTaskBar(), // Widget untuk menambahkan tugas
          _addDateBar(), // Widget untuk menampilkan tanggal
          SizedBox(
            height: 10,
          ),
          _showTasks(), // Widget untuk menampilkan daftar tugas
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan daftar tugas
  _showTasks() {
    return Expanded(child: Obx(() {
      // Menggunakan Obx untuk memperbarui tampilan saat terjadi perubahan pada variabel yang diamati (observable)
      return ListView.builder(
          itemCount:
              _taskController.taskList.length, // Jumlah item dalam daftar tugas
          itemBuilder: (_, index) {
            // Pembangunan item daftar tugas sesuai indeks
            Task task = _taskController
                .taskList[index]; // Mengambil tugas pada indeks tertentu
            if (task.repeat == 'daily') {
              // Jika tugas memiliki pengulangan harian
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    // Animasi untuk tampilan setiap item
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                              task), // Widget untuk menampilkan detail tugas
                        )
                      ],
                    )),
                  ));
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              // Jika tanggal tugas sesuai dengan tanggal yang dipilih
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    // Animasi untuk tampilan setiap item
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                              task), // Widget untuk menampilkan detail tugas
                        )
                      ],
                    )),
                  ));
            } else {
              return Container(); // Mengembalikan container kosong jika tidak memenuhi kondisi
            }
          });
    }));
  }

  // Fungsi untuk menampilkan bottom sheet dengan opsi tugas
  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      // Menampilkan bottom sheet menggunakan GetX (Get package)
      Container(
        padding: const EdgeInsets.only(top: 4),
        // Menyesuaikan tinggi bottom sheet berdasarkan kondisi tugas
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode
            ? darkGreyClr
            : Colors.white, // Mengatur warna latar belakang
        child: Column(
          children: [
            Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode
                        ? Colors.grey[600]
                        : Colors
                            .grey[300])), // Bagian dekoratif atas bottom sheet
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ), // Tombol untuk menandai tugas selesai jika belum selesai
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                _taskController.getTask();
                Get.back();
              },
              clr: Colors.red[300]!, // Warna tombol hapus
              context: context,
            ), // Tombol untuk menghapus tugas
            SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!, // Warna tombol tutup
              isClose: true,
              context: context,
            ), // Tombol untuk menutup bottom sheet
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  // Widget untuk tombol di bottom sheet
  _bottomSheetButton(
      {required String label, // Label untuk tombol
      required Function()?
          onTap, // Fungsi yang akan dipanggil saat tombol ditekan
      required Color clr, // Warna tombol
      bool isClose =
          false, // Parameter opsional untuk menentukan apakah tombol menutup bottom sheet
      required BuildContext context}) {
    // Konteks dari bottom sheet
    return GestureDetector(
      onTap: onTap, // Aksi yang dilakukan saat tombol ditekan
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4), // Spasi vertikal
        height: 55, // Tinggi tombol
        width: MediaQuery.of(context).size.width * 0.9, // Lebar tombol
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr), // Dekorasi border tombol
          borderRadius:
              BorderRadius.circular(20), // Membuat sudut tombol melengkung
          color: isClose == true
              ? Colors.transparent
              : clr, // Warna latar belakang tombol
        ),
        child: Center(
          child: Text(
            label, // Teks yang ditampilkan pada tombol
            style: isClose
                ? titleStyle // Styling teks jika tombol adalah tombol penutup
                : titleStyle.copyWith(
                    color: Colors.white), // Styling teks untuk tombol lainnya
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan pilihan tanggal
  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20), // Margin untuk posisi
      child: DatePicker(
        DateTime.now(), // Tanggal awal yang ditampilkan
        height: 90, // Tinggi widget
        width: 70, // Lebar widget
        initialSelectedDate: DateTime.now(), // Tanggal yang dipilih awalnya
        selectionColor: primaryClr, // Warna pemilihan tanggal
        selectedTextColor: Colors.white, // Warna teks tanggal yang dipilih
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey)), // Styling teks untuk tanggal
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey)), // Styling teks untuk hari
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey)), // Styling teks untuk bulan
        onDateChange: (date) {
          setState(() {
            _selectedDate = date; // Memperbarui tanggal yang dipilih
          });
        },
      ),
    );
  }

  // Widget untuk bagian tambah tugas
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
          left: 5, right: 20, top: 20), // Margin untuk penempatan
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMEd()
                      .format(DateTime.now()), // Teks format tanggal saat ini
                  style: subheadingStyle, // Styling teks untuk tanggal saat ini
                ),
                Text(
                  "Today", // Label 'Today'
                  style: headingStyle, // Styling teks untuk judul
                )
              ],
            ),
          ),
          MyButton(
            label: "+ Add Task", // Label tombol tambah tugas
            onTap: () async {
              await Get.to(
                  () => AddTaskPage()); // Navigasi ke halaman tambah tugas
              _taskController
                  .getTask(); // Memperbarui daftar tugas setelah penambahan
            },
          )
        ],
      ),
    );
  }

// Widget untuk app bar
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor:
          context.theme.backgroundColor, // Warna latar belakang app bar
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme(); // Mengganti tema aplikasi
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round, //Icon theme
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
}
