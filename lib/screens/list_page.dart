import 'package:flutter/material.dart';
import '../models/culinary_models.dart';
import 'detail_page.dart';
import 'login_page.dart';

/// Halaman Daftar Kuliner ([ListPage])
///
/// Halaman ini menampilkan katalog kuliner khas Indonesia menggunakan [ListView.builder].
/// Setiap item ditampilkan dalam bentuk kartu interaktif ([Card]) yang jika diklik
/// akan berpindah ke halaman [DetailPage] dengan membawa objek data kuliner terkait.
class ListPage extends StatelessWidget {
  // Opsional: menerima username dari halaman login untuk personalisasi salam
  final String username;

  const ListPage({
    super.key,
    this.username = 'Pecinta Kuliner',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar aplikasi dengan judul katalog dan tombol aksi logout
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Culinarizz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Katalog Kuliner Nusantara',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          // Tombol Logout untuk keluar dan kembali ke halaman Login
          IconButton(
            tooltip: 'Keluar / Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Dialog konfirmasi sebelum logout
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        // Menggunakan Navigator.pushReplacement untuk kembali ke LoginPage
                        // dan membersihkan history halaman sehingga user tidak bisa
                        // kembali ke ListPage dengan tombol back setelah logout.
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      // Body aplikasi menggunakan ListView.builder
      // Mengapa menggunakan ListView.builder?
      // 1. Efisiensi Memori (Lazy Loading): Hanya merender item yang sedang terlihat di layar.
      // 2. Sangat cocok untuk daftar data yang dinamis atau berjumlah banyak.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header Sapaan Pengguna
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, $username! 👋',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Temukan cita rasa khas dari berbagai daerah Nusantara',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ListView.builder untuk menampilkan daftar kuliner
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              // Menentukan jumlah total item yang akan dirender berdasarkan panjang list
              itemCount: dummyCulinaryList.length,
              // itemBuilder dipanggil untuk setiap item sesuai index-nya
              itemBuilder: (context, index) {
                // Mengambil objek data kuliner pada indeks ke-index
                final culinary = dummyCulinaryList[index];

                // Mengembalikan widget Card untuk setiap elemen kuliner
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  clipBehavior: Clip.antiAlias, // Memotong overflow anak widget agar rounded
                  child: InkWell(
                    // InkWell memberikan efek sentuhan visual (ripple effect) saat kartu ditekan
                    onTap: () {
                      // PENJELASAN NAVIGASI DENGAN PASSING DATA:
                      // Menggunakan Navigator.push untuk berpindah ke DetailPage.
                      // Objek 'culinary' dikirimkan secara langsung ke parameter constructor
                      // DetailPage(culinary: culinary), sehingga halaman detail dapat
                      // membaca dan menampilkan seluruh atribut dari item ini.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(culinary: culinary),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Gambar Kuliner (Network Image dengan rounded corner)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              // Tag unik untuk animasi Hero transisi ke DetailPage
                              tag: 'culinary_image_${culinary.id}',
                              child: Image.network(
                                culinary.imageUrl,
                                width: 95,
                                height: 95,
                                fit: BoxFit.cover,
                                // Placeholder saat gambar loading
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 95,
                                    height: 95,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                  );
                                },
                                // Fallback jika gambar gagal diakses
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 95,
                                    height: 95,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 32,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          // 2. Informasi Kuliner: Nama, Kategori, dan Asal Daerah
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Badge Kategori
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    culinary.category,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Nama Kuliner
                                Text(
                                  culinary.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),

                                // Asal Daerah (Ikon lokasi & nama daerah)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 15,
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        culinary.origin,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                // Ringkasan ekstra: Waktu penyajian & level pedas
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 13,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      culinary.prepTime,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.local_fire_department,
                                      size: 13,
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Pedas ${culinary.spicinessLevel}/5',
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 3. Ikon Panah Navigasi ke Kanan
                          const Padding(
                            padding: EdgeInsets.only(top: 36),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
