// Model data dan daftar dummy data kuliner Nusantara untuk aplikasi "Culinarizz"

/// Class model [Culinary] merepresentasikan struktur data untuk satu item kuliner.
/// Menggunakan class model mempermudah pengelolaan tipe data yang aman (type-safe)
/// dan memudahkan pengiriman data antar halaman (data passing).
class Culinary {
  // Deklarasi properti/atribut dengan keyword 'final' karena nilainya tidak diubah setelah diinisialisasi
  final String id;
  final String name; // Nama kuliner (contoh: Rendang Daging)
  final String category; // Kategori kuliner (contoh: Makanan Utama, Camilan, Sup)
  final String origin; // Asal daerah kuliner (contoh: Padang, Sumatera Barat)
  final List<String> mainIngredients; // Daftar bahan utama pembuatan kuliner
  final String taste; // Profil cita rasa (contoh: Gurih, Pedas, Berempah)
  final int spicinessLevel; // Skala kepedasan dari 1 (tidak pedas) hingga 5 (sangat pedas)
  final String prepTime; // Estimasi durasi memasak/waktu penyajian
  final String description; // Deskripsi lengkap sejarah/keunikan kuliner
  final String imageUrl; // URL gambar kuliner dari internet

  // Constructor dengan named parameter 'required' untuk memastikan
  // semua data harus diisi saat membuat objek baru dari class Culinary.
  const Culinary({
    required this.id,
    required this.name,
    required this.category,
    required this.origin,
    required this.mainIngredients,
    required this.taste,
    required this.spicinessLevel,
    required this.prepTime,
    required this.description,
    required this.imageUrl,
  });
}

/// Daftar dummy data kuliner khas Indonesia.
/// Digunakan sebagai pengganti database atau API eksternal untuk keperluan praktikum/kuis.
final List<Culinary> dummyCulinaryList = [
  const Culinary(
    id: 'c1',
    name: 'Rendang Daging',
    category: 'Makanan Utama',
    origin: 'Minangkabau, Sumatera Barat',
    mainIngredients: [
      'Daging Sapi Pilihan',
      'Santan Kelapa Murni',
      'Cabai Merah',
      'Lengkuas & Jahe',
      'Serai & Daun Kunyit',
      'Aneka Rempah Nusantara',
    ],
    taste: 'Gurih pekat, kaya rempah, dan pedas hangat',
    spicinessLevel: 4,
    prepTime: '4 - 5 Jam',
    description:
        'Rendang adalah masakan daging khas Minangkabau yang dimasak perlahan dengan santan dan rempah-rempah hingga kuah mengering dan meresap sempurna. Dinobatkan sebagai salah satu makanan terlezat di dunia versi CNN International.',
    imageUrl:
        'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c2',
    name: 'Gudeg Jogja Komplit',
    category: 'Makanan Tradisional',
    origin: 'D.I. Yogyakarta',
    mainIngredients: [
      'Nangka Muda (Gori)',
      'Santan Kental',
      'Gula Merah Jawa',
      'Daun Jati (Pewarna Alami)',
      'Telur Pindang',
      'Krecek & Ayam Kampung',
    ],
    taste: 'Manis legit, gurih santan, dan beraroma khas',
    spicinessLevel: 1,
    prepTime: '6 - 8 Jam',
    description:
        'Gudeg adalah hidangan khas Yogyakarta yang terbuat dari nangka muda yang dimasak berjam-jam bersama santan dan gula kelapa. Disajikan bersama nasi putih pulen, opor ayam, sambal goreng krecek pedas, dan telur pindang.',
    imageUrl:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c3',
    name: 'Pempek Palembang',
    category: 'Camilan & Kudapan',
    origin: 'Palembang, Sumatera Selatan',
    mainIngredients: [
      'Ikan Tenggiri Segar',
      'Tepung Sagu / Tapioka',
      'Gula Batok Aren',
      'Asam Jawa & Bawang Putih',
      'Cabai Rawit Hijau',
      'Ebi Kering Sangrai',
    ],
    taste: 'Gurih kenyal berpadu kuah cuko manis, asam, dan pedas',
    spicinessLevel: 3,
    prepTime: '45 Menit',
    description:
        'Pempek dibuat dari adonan daging ikan tenggiri yang digiling halus bersama tepung sagu, kemudian direbus atau digoreng hingga renyah di luar namun kenyal di dalam. Dinikmati bersama saus cuko hitam yang pekat dan asam pedas menyegarkan.',
    imageUrl:
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c4',
    name: 'Rawon Daging Sapi',
    category: 'Sup & Kuah',
    origin: 'Surabaya, Jawa Timur',
    mainIngredients: [
      'Daging Sapi (Sandung Lamur)',
      'Kluwek Hitam Matang',
      'Bawang Merah & Putih',
      'Serai & Daun Jeruk',
      'Tauge Pendek Segar',
      'Sambal Terasi & Telur Asin',
    ],
    taste: 'Gurih pekat dengan aroma kluwek yang earthy dan khas',
    spicinessLevel: 2,
    prepTime: '1.5 Jam',
    description:
        'Rawon adalah sup daging khas Jawa Timur yang memiliki kuah berwarna hitam pekat unik berkat bumbu kluwek. Hidangan legendaris ini memiliki kuah kaya kaldu yang lezat, disajikan dengan tauge pendek renyah, sambal terasi pedas, dan telur asin.',
    imageUrl:
        'https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c5',
    name: 'Sate Lilit Ikan Bali',
    category: 'Makanan Utama',
    origin: 'Klungkung & Denpasar, Bali',
    mainIngredients: [
      'Daging Ikan Laut Cincang',
      'Kelapa Parut Muda',
      'Batang Serai Segar',
      'Bumbu Base Genep Khas Bali',
      'Cabai Merah & Jeruk Limau',
    ],
    taste: 'Harum asap serai, gurih manis, dan berempah segar',
    spicinessLevel: 3,
    prepTime: '40 Menit',
    description:
        'Berbeda dari sate pada umumnya yang menusuk potongan daging, Sate Lilit dibuat dari daging ikan cincang yang dicampur kelapa parut dan bumbu base genep lengkap, lalu dililitkan melingkari batang serai kemudian dipanggang di atas bara tempurung kelapa.',
    imageUrl:
        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c6',
    name: 'Soto Betawi Kuah Susu',
    category: 'Sup & Kuah',
    origin: 'DKI Jakarta',
    mainIngredients: [
      'Daging Sapi & Jeroan',
      'Susu Sapi Murni & Santan',
      'Cengkeh, Kayu Manis, Kapulaga',
      'Kentang Rebus Goreng',
      'Tomat Segar & Daun Bawang',
      'Emping Melinjo Renyah',
    ],
    taste: 'Creamy lembut, gurih kaldu daging, dan kaya aroma rempah',
    spicinessLevel: 2,
    prepTime: '1 Jam',
    description:
        'Soto Betawi merupakan varian soto khas masyarakat Jakarta dengan kuah kental perpaduan santan dan susu sapi segar yang gurih dan wangi rempah. Dilengkapi potongan kentang, tomat segar, emping melinjo renyah, dan perasan jeruk nipis.',
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c7',
    name: 'Ayam Betutu Khas Gilimanuk',
    category: 'Makanan Tradisional',
    origin: 'Gilimanuk, Bali',
    mainIngredients: [
      'Ayam Utuh Segar',
      'Base Genep (Rempah 16 Rasa)',
      'Minyak Kelapa Tandusan',
      'Daun Pisang Pilihan',
      'Cabai Rawit Merah Melimpah',
    ],
    taste: 'Sangat pedas menyengat, berbumbu tajam, dan daging lembut',
    spicinessLevel: 5,
    prepTime: '3 - 4 Jam',
    description:
        'Ayam Betutu adalah masakan kebanggaan masyarakat Bali di mana ayam utuh dibalur rempah base genep pekat dengan cabai rawit pedas, dibungkus daun pisang berlapis, lalu dikukus dan dipanggang hingga bumbu meresap ke serat daging terdalam.',
    imageUrl:
        'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=800&q=80',
  ),
  const Culinary(
    id: 'c8',
    name: 'Nasi Liwet Solo Gurih',
    category: 'Makanan Tradisional',
    origin: 'Surakarta, Jawa Tengah',
    mainIngredients: [
      'Beras Putih Pulen',
      'Santan Kelapa Gurih',
      'Daun Salam & Batang Serai',
      'Suwiran Ayam Opor',
      'Sayur Labu Siam Pedas',
      'Areh Santan Kental',
    ],
    taste: 'Gurih harum pandan dan serai dengan kuah areh lembut',
    spicinessLevel: 2,
    prepTime: '50 Menit',
    description:
        'Nasi Liwet Solo dimasak menggunakan santan kelapa gurih beraroma daun salam dan serai. Tradisi penyajiannya beralaskan daun pisang pincuk dengan lauk suwiran ayam gurih, sayur jipang/labu siam berkuah santan pedas, serta areh putih kental yang gurih khas keraton.',
    imageUrl:
        'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80',
  ),
];
