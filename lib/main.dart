import 'package:final_project_mobile/db/db_helper.dart';
import 'package:get/get.dart';
import 'package:final_project_mobile/services/theme_services.dart';
import 'package:final_project_mobile/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/ui/home_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  // Memastikan bahwa Flutter Binding telah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Memanggil fungsi untuk menginisialisasi database
  await DBHelper.db();

  // Menginisialisasi penyimpanan lokal GetStorage
  await GetStorage.init();

  // Menjalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget yang menjadi akar dari aplikasi
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light, // Tema aplikasi dalam light mode
        darkTheme: Themes.dark, // Tema aplikasi dalam dark mode
        themeMode:
            ThemeService().theme, // Mode tema yang digunakan dari ThemeService
        home: HomePage()); // Halaman utama aplikasi
  }
}
