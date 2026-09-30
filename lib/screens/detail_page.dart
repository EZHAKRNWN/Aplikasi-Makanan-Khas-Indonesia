import 'package:flutter/material.dart';
import '../models/culinary_models.dart';

/// Halaman Detail Kuliner ([DetailPage])
///
/// Halaman ini menampilkan seluruh informasi detail dari objek [Culinary]
/// yang dikirimkan dari halaman daftar kuliner ([ListPage]).
///
/// Menggunakan [StatefulWidget] karena terdapat fitur interaktif perubahan status:
/// yaitu tombol favorit (Heart Icon) yang dapat berubah status (aktif/tidak aktif)
/// dan memerlukan fungsi `setState()` untuk memperbarui tampilan UI secara dinamis.
class DetailPage extends StatefulWidget {
  // Objek kuliner diterima melalui parameter constructor halaman ini
  final Culinary culinary;

  const DetailPage({
    super.key,
    required this.culinary,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // State lokal untuk melacak apakah kuliner ini dijadikan favorit oleh user
  // Default: false (belum difavoritkan)
  bool _isFavorite = false;

  /// Fungsi untuk mengubah status favorit dan memicu pembaruan tampilan
  void _toggleFavorite() {
    // Menggunakan setState() untuk memberi tahu framework Flutter
    // bahwa nilai state lokal '_isFavorite' telah berubah, sehingga
    // Flutter akan menjalankan ulang method build() untuk merender ikon terbaru.
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Menampilkan feedback interaktif kepada pengguna berupa SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _isFavorite
                    ? '${widget.culinary.name} berhasil ditambahkan ke Favorit! ❤️'
                    : '${widget.culinary.name} dihapus dari Favorit.',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: _isFavorite ? Colors.redAccent : Colors.grey[800],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengakses data kuliner yang dikirim melalui 'widget.culinary'
    final item = widget.culinary;

    return Scaffold(
      // AppBar dengan tombol back default dan tombol favorit di sisi kanan
      appBar: AppBar(
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Menggunakan IconButton di actions AppBar sebagai tombol favorit (Heart Icon)
        actions: [
          IconButton(
            tooltip: _isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
            // Logika ternary operator untuk menentukan tampilan ikon:
            // Jika _isFavorite true: tampilkan ikon Icons.favorite berwarna merah (red)
            // Jika _isFavorite false: tampilkan ikon Icons.favorite_border berwarna abu-abu
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey[400],
              size: 28,
            ),
            // Memanggil fungsi _toggleFavorite ketika tombol ditekan
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      // SingleChildScrollView mencegah error RenderFlex overflow ketika konten melebihi tinggi layar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bagian Gambar Utama (Header Image)
            Stack(
              children: [
                Hero(
                  // Hero widget memberikan animasi transisi halus dari halaman list ke detail
                  tag: 'culinary_image_${item.id}',
                  child: Image.network(
                    item.imageUrl,
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                    // Penanganan saat gambar sedang dimuat
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 260,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    // Penanganan jika gambar gagal dimuat dari URL
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 260,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 64,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Efek gradient bayangan di bagian bawah gambar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Floating Action Favorite Button tepat di pojok kanan bawah gambar (Bonus UI)
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: FloatingActionButton.small(
                    heroTag: 'fab_fav_${item.id}',
                    backgroundColor: Colors.white,
                    onPressed: _toggleFavorite,
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            // 2. Bagian Informasi Detail Konten
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Kuliner
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Kategori & Asal Daerah
                  Row(
                    children: [
                      // Chip Kategori
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.category,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Asal Daerah dengan ikon lokasi
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.origin,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // 3. Kartu Ringkasan Atribut (Cita Rasa, Kepedasan, Waktu Penyajian)
                  Row(
                    children: [
                      // Cita Rasa Card
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.restaurant_menu,
                          iconColor: Colors.orange,
                          label: 'Cita Rasa',
                          value: item.taste,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Tingkat Kepedasan Card
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.local_fire_department,
                          iconColor: Colors.deepOrange,
                          label: 'Kepedasan',
                          value: 'Level ${item.spicinessLevel} / 5',
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Waktu Penyajian Card
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.timer_outlined,
                          iconColor: Colors.blueAccent,
                          label: 'Penyajian',
                          value: item.prepTime,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 4. Bagian Bahan Utama (Main Ingredients)
                  Text(
                    'Bahan-Bahan Utama',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Menggunakan Wrap agar daftar chip bahan dapat otomatis turun baris
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: item.mainIngredients.map((ingredient) {
                      return Chip(
                        avatar: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                        label: Text(
                          ingredient,
                          style: const TextStyle(fontSize: 13),
                        ),
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // 5. Bagian Deskripsi Lengkap
                  Text(
                    'Deskripsi Kuliner',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget untuk membuat kartu informasi ringkas (Cita Rasa, Pedas, Waktu)
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
