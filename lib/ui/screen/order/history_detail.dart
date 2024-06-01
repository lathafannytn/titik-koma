// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DetailHistoryOrderScreen extends StatelessWidget {
  final String status;
  final String date;
  final String time;
  final String location;
  final List<String> items;
  final int totalItems;
  final int totalPrice;
  final String orderId;
  final String orderTime;
  final String orderChannel;
  final String paymentMethod;
  final int voucher;
  final int points;

  DetailHistoryOrderScreen({
    required this.status,
    required this.date,
    required this.time,
    required this.location,
    required this.items,
    required this.totalItems,
    required this.totalPrice,
    required this.orderId,
    required this.orderTime,
    required this.orderChannel,
    required this.paymentMethod,
    required this.voucher,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.check_circle_outline_outlined, color: Colors.green),
                    SizedBox(width: 8.0),
                    Text(
                      'Pesanan Selesai',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Card(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'detail location'

                    ),
                    SizedBox(height: 12.0),
                    ...items.map((item) => Text(item)).toList(),
                    Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal'),
                        Text('Rp ${totalPrice + voucher}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Voucher'),
                        Text('- Rp $voucher', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp $totalPrice',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TIKOM Points'),
                        Text('Waktu Pemesanan'),
                        Text('Saluran Pesanan'),
                        Text('Metode Pembayaran'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('+$points pts'),
                        Text(orderTime),
                        Text(orderChannel),
                        Text(paymentMethod),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}