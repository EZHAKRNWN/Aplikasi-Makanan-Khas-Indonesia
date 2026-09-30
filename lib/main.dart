import 'package:flutter/material.dart';
import 'screens/login_page.dart';

/// Titik masuk utama (Entry Point) eksekusi aplikasi Flutter.
/// Fungsi [main] adalah fungsi yang pertama kali dijalankan oleh sistem Dart/Flutter.
void main() {
  // runApp() bertugas menginstansiasi widget root [CulinarizzApp]
  // dan menampilkannya pada layar perangkat pengguna.
  runApp(const CulinarizzApp());
}

/// Widget root aplikasi [CulinarizzApp].
/// Menggunakan [StatelessWidget] karena konfigurasi root aplikasi ini bersifat statis
/// dan tidak mengalami perubahan state secara langsung di level aplikasi.
class CulinarizzApp extends StatelessWidget {
  const CulinarizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget pembungkus utama yang menyediakan fitur-fitur
    // standar Material Design seperti navigasi rute, tema aplikasi, dan lokalisasi.
    return MaterialApp(
      // Judul aplikasi yang muncul di task switcher perangkat
      title: 'Culinarizz',

      // Menonaktifkan banner tulisan 'DEBUG' di pojok kanan atas layar
      debugShowCheckedModeBanner: false,

      // Konfigurasi tema global aplikasi (ThemeData)
      theme: ThemeData(
        // Mengaktifkan Material Design versi 3 (M3)
        useMaterial3: true,

        // Palet warna dasar (seed color) bernuansa hangat (deep orange)
        // yang sangat cocok untuk tema kuliner nusantara
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE65100), // Oranye Tua hangat
          brightness: Brightness.light,
        ),

        // Kustomisasi tema AppBar di seluruh halaman aplikasi
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xFFE65100),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),

        // Kustomisasi tema Card agar memiliki sudut melengkung dan elevasi konsisten
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        // Kustomisasi tema tombol ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // Menetapkan halaman awal (home screen) saat aplikasi pertama kali dibuka.
      // Di sini kita arahkan ke [LoginPage].
      home: const LoginPage(),
    );
  }
}
