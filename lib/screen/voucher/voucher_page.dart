// voucherpage.dart
import 'package:flutter/material.dart';
import 'voucher.dart';  // Import the Voucher model
import 'voucher_card.dart';  // Import the VoucherCard widget

class VoucherPage extends StatelessWidget {
  final List<Voucher> vouchers = [
    Voucher(
      id: '001',
      title: 'Summer Sale',
      description: 'Get 20% off on your next summer purchase!',
      imageUrl: 'https://example.com/image1.jpg',
      discount: 20.0,
    ),
    Voucher(
      id: '002',
      title: 'Winter Special',
      description: 'Save 15% on all winter gear!',
      imageUrl: 'https://example.com/image2.jpg',
      discount: 15.0,
    ),
    Voucher(
      id: '003',
      title: 'Back to School',
      description: 'Books, bags, and more at 25% off!',
      imageUrl: 'https://example.com/image3.jpg',
      discount: 25.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Vouchers'),
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return VoucherCard(voucher: vouchers[index]);
        },
      ),
    );
  }
}
