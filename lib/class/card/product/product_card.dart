import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class ProductCard extends StatelessWidget {
//   final String name;
//   final String price;
//   final String imagePath;

//   ProductCard(
//       {required this.name, required this.price, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     int priceValue = int.tryParse(price) ?? 0;
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topLeft,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Spacer(),
//                 Text(
//                   name,
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   '\$${priceValue.toString()}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: 15),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 5,
//             top: -50,
//             child: Image.asset(
//               imagePath,
//               width: 90,
//               height: 150,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 10,
//             child: FloatingActionButton(
//               onPressed: () => print('Add to cart'),
//               child: Icon(Icons.add, color: Colors.white),
//               backgroundColor: Colors.green,
//               mini: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class ProductCard extends StatelessWidget {
  final String name;
  final num price;
  final String imagePath;

  ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Deskripsi produk di sini', // Ganti dengan deskripsi asli jika ada
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Rp ${price.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk menambah produk ke keranjang
              },
              icon: Icon(Icons.add_circle, color: Color.fromARGB(255, 9, 76, 58)),
            ),
          ],
        ),
      ),
    );
  }
}

