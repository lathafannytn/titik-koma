import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tikom/data/repository/my_voucher_repository.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/screen/voucher/qr_scan.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/ui/widgets/loading_dialog.dart';

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

  void handlerClaimVoucher() async {
    LoadingDialog.show(context, barrierColor: const Color(0xFF777C7E));
    try {
      final MyVoucherRepository myVoucherRepository = MyVoucherRepository();
      final response = await myVoucherRepository.claimVoucher(
          code: _voucherCodeController.text);
      print(response);
      if (response.status == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        DialogTemp().Informasi(
            context: context,
            onYes: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            tabIndex: 3,
                          )));
            },
            onYesText: 'Lanjut',
            title: response.message);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        DialogTemp().Informasi(
            context: context,
            onYes: () {
              Navigator.pop(context);
            },
            onYesText: 'Oke',
            title: response.message);
      }
    } catch (error) {
      print(error.toString());
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      DialogTemp().Informasi(
          context: context,
          onYes: () {
            Navigator.pop(context);
          },
          onYesText: 'Oke',
          title: 'Claim Gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tukar Voucher',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _voucherCodeController,
                    decoration: InputDecoration(
                      labelText: 'Masukan kode voucher anda',
                      suffixIcon: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRViewExample()),
                          );
                          if (result != null) {
                            setState(() {
                              _voucherCodeController.text = result;
                              handlerClaimVoucher();
                            });
                          }
                        },
                        child: const Icon(Icons.qr_code_scanner),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      handlerClaimVoucher();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text('Gunakan'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'S&K',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
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
