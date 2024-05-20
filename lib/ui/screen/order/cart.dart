import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Belanja',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 20, 63, 49),
      ),
      body: ListView.builder(
        itemCount: 3, // Ubah sesuai dengan jumlah item di keranjang
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset('assets/images/kopi_aren_doppio.jpg'),
            title: Text(
              'Kopi Aren Doppio',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '1 x Rp 29.000',
              style: GoogleFonts.poppins(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Logika untuk menghapus item dari keranjang
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[300]!, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp 87.000',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 20, 63, 49),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                // Logika untuk melanjutkan ke proses pembayaran
              },
              child: Text(
                'Checkout',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
