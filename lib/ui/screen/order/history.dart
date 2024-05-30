import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'history_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RiwayatPemesananScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class RiwayatPemesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Pemesanan',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Implementasikan fungsi pengaturan
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          buildOrderCard(
            context,
            status: 'Dibatalkan',
            date: '30/05/2024',
            time: '14:49',
            location: 'Ruko Kayoon',
            items: ['Matcha Oat Latte'],
            totalItems: 1,
            totalPrice: 28000,
            orderId: 'TO2024042818265914295',
            orderTime: '28/04/2024 18:26',
            orderChannel: 'APP',
            paymentMethod: 'ShopeePay',
            voucher: 16000,
            points: 18,
          ),
          buildOrderCard(
            context,
            status: 'Berhasil',
            date: 'Jumat, 15 Des 2023',
            time: '18:14',
            location: 'Tunjungan Plaza 6',
            items: ['1 Iced Light Buttercream Latte'],
            totalItems: 1,
            totalPrice: 29000,
            orderId: 'TO2023121518145914295',
            orderTime: '15/12/2023 18:14',
            orderChannel: 'APP',
            paymentMethod: 'GoPay',
            voucher: 0,
            points: 10,
          ),
          buildOrderCard(
            context,
            status: 'Berhasil',
            date: 'Kamis, 09 Feb 2023',
            time: '18:24',
            location: 'Tunjungan Plaza 6',
            items: ['1 Iced Banana Butter Latte', '1 Hibiscus Berry Yakult'],
            totalItems: 2,
            totalPrice: 38000,
            orderId: 'TO2023020918245914295',
            orderTime: '09/02/2023 18:24',
            orderChannel: 'APP',
            paymentMethod: 'OVO',
            voucher: 5000,
            points: 20,
          ),
        ],
      ),
    );
  }

  Widget buildOrderCard(
    BuildContext context, {
    required String status,
    required String date,
    required String time,
    required String location,
    required List<String> items,
    required int totalItems,
    required int totalPrice,
    required String orderId,
    required String orderTime,
    required String orderChannel,
    required String paymentMethod,
    required int voucher,
    required int points,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryOrderScreen(
              status: status,
              date: date,
              time: time,
              location: location,
              items: items,
              totalItems: totalItems,
              totalPrice: totalPrice,
              orderId: orderId,
              orderTime: orderTime,
              orderChannel: orderChannel,
              paymentMethod: paymentMethod,
              voucher: voucher,
              points: points,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text('$date $time'),
              SizedBox(height: 8.0),
              ...items.map((item) => Text(item)).toList(),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$totalItems item • Rp $totalPrice'),
                  ElevatedButton(
                    onPressed: () {
                      // Implementasikan fungsi pesan lagi
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.grey),
                      elevation: 0, // Hilangkan bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('Pesan Lagi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


