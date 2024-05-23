import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/order/add_on.dart';

class ProductCard extends StatelessWidget {
  final String uuid;
  final String name;
  final num price;
  final String imagePath;

  ProductCard({
    required this.uuid,
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
            const SizedBox(width: 10),
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
                  const SizedBox(height: 5),
                  Text(
                    'Deskripsi produk di sini', // Ganti dengan deskripsi asli jika ada
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
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
                print("IconButton pressed");
                print(uuid);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOnScreen(uuid: uuid,)),
                );
              },
              icon:
                  Icon(Icons.add_circle, color: Color.fromARGB(255, 9, 76, 58)),
            ),
          ],
        ),
      ),
    );
  }
}
