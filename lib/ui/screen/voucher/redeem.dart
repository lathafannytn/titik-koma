import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tikom/ui/screen/voucher/qr_scan.dart';

class RedeemVoucherPage extends StatefulWidget {
  @override
  _RedeemVoucherPageState createState() => _RedeemVoucherPageState();
}

class _RedeemVoucherPageState extends State<RedeemVoucherPage> {
  final TextEditingController _voucherCodeController = TextEditingController();

  @override
  void dispose() {
    _voucherCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tukar Voucher',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Image.network(
                    'https://www.clipartmax.com/png/middle/245-2456783_gift-voucher-png.png', // Ganti dengan URL gambar yang sesuai
                    height: 150,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _voucherCodeController,
                    decoration: InputDecoration(
                      labelText: 'Masukan kode voucher anda',
                      suffixIcon: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QRViewExample()),
                          );
                          if (result != null) {
                            setState(() {
                              _voucherCodeController.text = result;
                            });
                          }
                        },
                        child: Icon(Icons.qr_code_scanner),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika penukaran voucher di sini
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Gunakan'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'S&K',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Kode voucher hanya dapat ditukarkan dengan voucher TOMORO, tidak dapat ditukarkan dengan uang tunai.\n'
              '2. Kode penukaran hanya dapat digunakan satu kali saja. Setelah penukaran berhasil, kode akan langsung menjadi tidak valid dan tidak dapat ditukarkan lagi.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

