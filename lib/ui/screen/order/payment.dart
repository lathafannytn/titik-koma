// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class PaymentMethodScreen extends StatefulWidget {
  final int totalAmount;

  const PaymentMethodScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'Gopay';

  void _selectMethod(String method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  Widget _buildPaymentMethodTile(String method, String iconUrl) {
    return ListTile(
      leading: Image.asset(iconUrl, width: 20),
      title: Text(method),
      trailing: Radio<String>(
        value: method,
        groupValue: _selectedMethod,
        onChanged: (String? value) {
          if (value != null) {
            _selectMethod(value);
          }
        },
      ),
      onTap: () => _selectMethod(method),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Rp ${NumberFormat("#,##0", "id_ID").format(widget.totalAmount)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metode Pembayaran',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPaymentMethodTile('Gopay', 'assets/logos/gopay.png'),
                  _buildPaymentMethodTile('OVO', 'assets/logos/ovo.png'),
                  _buildPaymentMethodTile('DANA', 'assets/logos/dana.png'),
                  _buildPaymentMethodTile('LinkAja', 'assets/logos/linkaja.png'),
                  _buildPaymentMethodTile('ShopeePay', 'assets/logos/shopee.png'),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle payment method selection
                print('Selected Method: $_selectedMethod');
              },
              child: Text('Bayar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
