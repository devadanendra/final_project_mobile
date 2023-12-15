import 'package:final_project_mobile/models/task.dart';
import 'package:final_project_mobile/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget TaskTile digunakan untuk menampilkan detail data dalam bentuk kotak
class TaskTile extends StatelessWidget {
  final Task? task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    // Membuat kotak untuk menampilkan detail "tugas/data"
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        // Menyesuaikan warna latar belakang kotak berdasarkan nomor tugas
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? 0), // warna latar belakang dari angka
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "", // Menampilkan judul tugas
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // Gaya teks judul
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded, // Menampilkan ikon jam
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}", // Menampilkan rentang waktu tugas
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 13,
                            color:
                                Colors.grey[100]), // Styling teks rentang waktu
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  task?.note ?? "", // Menampilkan catatan terkait tugas
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100]), // Styling teks note
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1
                  ? "COMPLETED"
                  : "TODO", // Menampilkan status tugas
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Styling teks status
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // Mendapatkan warna background berdasarkan nomor tugas
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr; // Warna background untuk nomor 0
      case 1:
        return pinkClr; // Warna background untuk nomor 1
      case 2:
        return yellowClr; // Warna background untuk nomor 2
      default:
        return bluishClr; // Warna ldefault
    }
  }
}
