import 'package:final_project_mobile/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Widget MyInputField digunakan untuk membuat sebuah input field dengan label dan hint tertentu
class MyInputField extends StatelessWidget {
  final String title; // Judul input field
  final String hint; // Hint untuk input field
  final TextEditingController? controller; // Controller untuk input field
  final Widget? widget; // Widget tambahan jika diperlukan

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16), // Margin atas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // Menampilkan judul input field
            style: titleStyle, // Gaya teks judul
          ),
          Container(
            height: 52, // Tinggi input field
            margin: EdgeInsets.only(top: 8.0), // Margin atas input field
            padding: EdgeInsets.only(left: 14), // Padding kiri input field
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey, width: 1.0), // Dekorasi border
              borderRadius:
                  BorderRadius.circular(12), // Border radius input field
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null
                      ? false
                      : true, // Input field hanya baca jika widget ada
                  autofocus: false, // Autofokus dinonaktifkan
                  cursorColor: Get.isDarkMode
                      ? Colors.grey[100]
                      : Colors.grey, // Warna kursor
                  controller:
                      controller, // Menggunakan controller yang diberikan
                  style: subTitleStyle, // Gaya teks input field
                  decoration: InputDecoration(
                    hintText: hint, // Menampilkan hint pada input field
                    hintStyle: subTitleStyle, // Gaya teks hint
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width:
                                0)), // Garis bawah saat input field difokuskan
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width:
                                0)), // Garis bawah saat input field tidak difokuskan
                  ),
                )),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
