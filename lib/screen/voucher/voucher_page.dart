// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tikom/screen/voucher/redeem.dart';
import 'package:tikom/screen/voucher/voucher_card.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voucher Saya',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            VoucherCard(
              title: "Exclusive Benefits Diskon 30%",
              description: "S&K",
              expiryDate: "19/05/2024",
              discount: "30% OFF",
            ),
            VoucherCard(
              title: "Weekly | 1 Cup Disc 1K",
              description: "Min 1 produk",
              expiryDate: "15/05/2024",
              discount: "Disc 1k",
            ),
            VoucherCard(
              title: "Weekly | 2 Cups Disc 5K",
              description: "Min 2 produk",
              expiryDate: "15/05/2024",
              discount: "Disc 5k",
            ),
            VoucherCard(
              title: "Weekly | 3 Cups Disc 15K",
              description: "Min 3 produk",
              expiryDate: "15/05/2024",
              discount: "Disc 15k",
            ),
            VoucherCard(
              title: "RAIH DISKON ONGKIR!!!",
              description: "Min 2 produk",
              expiryDate: "17/05/2024",
              discount: "GRATIS ONGKIR",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RedeemVoucherPage()),
            );
          },
          icon: Icon(Icons.card_giftcard, color: Colors.black),
          label: Text(
            "Masukan Kode Voucher",
            style: TextStyle(color: Colors.black),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ),
    );
  }
}
