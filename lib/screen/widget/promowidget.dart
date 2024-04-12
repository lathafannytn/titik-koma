import 'package:flutter/material.dart';

class PromoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Mendapatkan lebar layar

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0, // Menyesuaikan jarak dari pojok kiri dan kanan
        ),
        child: Container(
          width: screenWidth - 20.0, // Menggunakan lebar layar dikurangi jarak kiri dan kanan
          height: 300.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 232, 150, 76), // Warna latar belakang
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Mulai dari kiri
            crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan secara vertikal
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  "assets/images/promo.png",
                  fit: BoxFit.contain, // Sesuaikan gambar dengan kontainer
                ),
              ),
              SizedBox(width: 20), // Spasi antara gambar dan teks
              Column(
                mainAxisSize: MainAxisSize.min, // Konten tidak akan melewati batas
                crossAxisAlignment: CrossAxisAlignment.start, // Mulai dari kiri
                children: [
                  Text(
                    'Special for You', // Teks yang ingin ditampilkan
                    style: TextStyle(
                      fontSize: 20.0, // Ukuran teks
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ketebalan teks
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Drinks Only', // Teks yang ingin ditampilkan
                    style: TextStyle(
                      fontSize: 34.0, // Ukuran teks
                      fontWeight: FontWeight.w800,
                      color: Colors.white, // Ketebalan teks
                    ),
                  ),
                  SizedBox(height: 20.0), // Spasi antara teks dan tombol
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 50, 50, 50), // Warna tombol
                      onPrimary: Colors.white, // Warna teks tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Atur radius sudut di sini
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
