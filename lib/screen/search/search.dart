import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String textToDisplay = "INI Search!"; // Ganti dengan teks yang ingin Anda panggil

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Memastikan tidak ada yang keluar dari batas card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      child: Stack(
        alignment: Alignment.bottomRight, // Menyusun elemen di bawah dan kanan
        children: [
          Positioned(
            top: -20, // Menggeser gambar ke atas agar melebihi batas atas
            left: -20, // Menggeser gambar ke kiri agar melebihi batas kiri
            child: Image.asset(
              'assets/images/icon_drinks.png', // Ganti dengan path image minuman yang sebenarnya
              width: 150, // Ukuran gambar
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10), // Padding di dalam card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Refreshing Soda',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$2.99',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10, // Posisi tombol di kanan bawah
            bottom: 10,
            child: FloatingActionButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                print('Add to cart');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green, // Warna latar belakang tombol
              mini: true, // Membuat ukuran tombol lebih kecil
            ),
          ),
        ],
      ),
    );
  }
}
