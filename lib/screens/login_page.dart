import 'package:flutter/material.dart';
import 'list_page.dart';

/// Halaman Login ([LoginPage])
///
/// Halaman ini berfungsi sebagai gerbang autentikasi pengguna ke dalam aplikasi Culinarizz.
/// Menggunakan [StatefulWidget] karena terdapat pengelolaan status (state) dinamis:
/// 1. Teks input yang dikontrol oleh [TextEditingController]
/// 2. Status visibilitas kata sandi (show/hide password)
/// 3. Validasi form menggunakan [GlobalKey<FormState>]
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // GlobalKey digunakan untuk mengidentifikasi dan memvalidasi Form widget secara unik
  final _formKey = GlobalKey<FormState>();

  // Controller untuk membaca nilai input teks username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State boolean untuk mengatur apakah teks password disamarkan (obscure) atau ditampilkan
  bool _isPasswordObscure = true;

  // Nilai password yang ditentukan sesuai aturan soal: tepat "142" (3 digit terakhir NIM)
  static const String _correctPassword = '142';

  @override
  void dispose() {
    // Wajib memanggil dispose() pada TextEditingController saat widget dihancurkan
    // untuk mencegah kebocoran memori (memory leak).
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Fungsi untuk menangani logika autentikasi saat tombol login ditekan
  void _handleLogin() {
    // 1. Memeriksa apakah seluruh validasi TextFormField di dalam Form telah terpenuhi
    if (_formKey.currentState!.validate()) {
      final inputUsername = _usernameController.text.trim();
      final inputPassword = _passwordController.text.trim();

      // 2. LOGIKA VALIDASI PASSWORD:
      // Password HARUS tepat bernilai "142" sesuai instruksi soal kuis.
      if (inputPassword == _correctPassword) {
        // Tampilkan pesan notifikasi berhasil login
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('Login Berhasil! Selamat datang, $inputUsername.'),
                ),
              ],
            ),
            backgroundColor: Colors.green[700],
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // 3. LOGIKA NAVIGASI KE HALAMAN LIST:
        // Menggunakan Navigator.pushReplacement agar halaman LoginPage digantikan
        // oleh ListPage pada tumpukan stack route. Pengguna tidak akan kembali
        // ke halaman login saat menekan tombol back perangkat di ListPage.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListPage(
              username: inputUsername.isNotEmpty ? inputUsername : 'Mahasiswa',
            ),
          ),
        );
      } else {
        // Jika password bukan "142", tampilkan notifikasi kesalahan
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Password salah! Gunakan 142 (3 digit terakhir NIM).',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background bertema hangat khas nuansa kuliner
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        // Center dan SingleChildScrollView memastikan form tetap responsif dan tidak overflow di layar kecil
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              // Menghubungkan formKey untuk validasi form
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1. Icon Logo & Branding Aplikasi
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.restaurant_rounded,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Judul Aplikasi
                  Text(
                    'Culinarizz',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 0.5,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Eksplorasi Kelezatan Kuliner Tradisional Nusantara',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 2. Kartu Form Input (Card UI Container)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Masuk ke Akun',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),

                          // Form Field: Username
                          TextFormField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Masukkan nama / username Anda',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            // Validasi input username tidak boleh kosong
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Form Field: Password
                          TextFormField(
                            controller: _passwordController,
                            // obscureText menyembunyikan karakter kata sandi menjadi titik
                            obscureText: _isPasswordObscure,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Masukkan password (142)',
                              prefixIcon: const Icon(Icons.lock_outline),
                              // Tombol icon di akhir input untuk toggle visibilitas password
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  // Memperbarui state boolean _isPasswordObscure
                                  setState(() {
                                    _isPasswordObscure = !_isPasswordObscure;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            // Validasi input password
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),

                          // Petunjuk Password (Bantuan untuk penguji kuis)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Petunjuk Kuis: Password adalah 142 (3 digit NIM)',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.amber[900],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 3. Tombol Login (ElevatedButton)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _handleLogin,
                            child: const Text(
                              'MASUK (LOGIN)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Footer info praktikum
                  Text(
                    'Praktikum Pemrograman Aplikasi Mobile\nCheatsheet Kuis Flutter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
