import 'package:flutter/material.dart';
import 'voucher.dart';  

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  VoucherCard({required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(
            voucher.imageUrl,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              voucher.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              voucher.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Discount: ${voucher.discount}%',
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
