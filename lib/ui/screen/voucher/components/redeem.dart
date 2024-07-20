// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tikom/data/repository/my_voucher_repository.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/screen/voucher/components/qr_scan.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/ui/widgets/loading_dialog.dart';

import '../../../../utils/constant.dart';
import 'voucher_card.dart';

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
        Navigator.pop(context);
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
        Navigator.pop(context);
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
      Navigator.pop(context);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tikom Redeem',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            // Wrap in Expanded to take up remaining space
            child: SingleChildScrollView(
              child: Padding(
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
                          Image.asset(
                            'assets/logos/logo_tikom_hijau_hitam.png',
                            height: 150,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _voucherCodeController,
                            decoration: InputDecoration(
                              labelText: 'Masukan kode voucher anda',
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 9, 76, 58)),
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 19, 78, 70)),
                              ),
                            ),
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              handlerClaimVoucher();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Constants.primaryColor,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              'Gunakan',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
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
                      '1. Kode voucher hanya dapat ditukarkan dengan voucher TIKOM, tidak dapat ditukarkan dengan uang tunai.\n'
                      '2. Kode penukaran hanya dapat digunakan satu kali saja. Setelah penukaran berhasil, kode akan langsung menjadi tidak valid dan tidak dapat ditukarkan lagi.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    VoucherCard(
                      title: 'Voucher Spesial',
                      description:'Voucher TIKOM.',
                      expiryDate: '31 Desember 2024',
                      discount: '50%',
                      onclick: () {
                        print('Voucher digunakan');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
