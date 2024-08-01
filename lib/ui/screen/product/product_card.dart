import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Tambahkan ini
import 'package:tikom/ui/screen/order/add_on.dart';

class ProductCard extends StatelessWidget {
  final String uuid;
  final String name;
  final num price;
  final String description;
  final String imagePath;
  final dynamic stock;

  ProductCard({
    required this.uuid,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.stock,
  });

  // Tambahkan fungsi formatCurrency
  String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

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
              child: CachedNetworkImage(
                imageUrl: imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatCurrency(price), // Gunakan formatCurrency di sini
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: stock != 0
                  ? () {
                      print("IconButton pressed");
                      print(uuid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOnScreen(
                            uuid: uuid,
                          ),
                        ),
                      );
                    }
                  : null,
              icon: Icon(
                Icons.add_circle_outline_outlined,
                color: stock != 0
                    ? const Color.fromARGB(255, 3, 115, 76)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
