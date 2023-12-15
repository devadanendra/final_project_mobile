import 'package:final_project_mobile/ui/theme.dart';
import 'package:flutter/material.dart';

// MyButton adalah widget yang menampilkan sebuah tombol dengan label tertentu
class MyButton extends StatelessWidget {
  final String label; // Label yang akan ditampilkan pada tombol
  final Function()? onTap; // Fungsi yang akan dieksekusi saat tombol ditekan

  const MyButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Menjalankan fungsi onTap ketika tombol ditekan
      child: Container(
        width: 88, // Lebar tombol
        height: 51, // Tinggi tombol
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Membuat sudut melengkung pada tombol
          color: primaryClr, // Warna latar belakang tombol
        ),
        child: Center(
          child: Text(
            label, // Menampilkan label pada tombol
            style: TextStyle(
              color: Colors.white, // Warna teks pada tombol
            ),
          ),
        ),
      ),
    );
  }
}
