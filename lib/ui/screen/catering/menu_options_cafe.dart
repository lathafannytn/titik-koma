import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card/option.dart';

class MenuOptionCafe extends StatefulWidget {
  @override
  _MenuOptionCafeState createState() => _MenuOptionCafeState();
}

class _MenuOptionCafeState extends State<MenuOptionCafe> {
  List<String> checkedItems = [];

  void handleToggle(String uuid, bool isChecked) {
    setState(() {
      if (isChecked) {
        checkedItems.add(uuid);
      } else {
        checkedItems.remove(uuid);
      }
    });
  }

  void _showCheckedItems(BuildContext context) {
    var checkedProducts = productData
        .where((product) => checkedItems.contains(product['uuid']))
        .toList();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cart',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...checkedProducts.map((product) {
                return ListTile(
                  title: Text(product['name'], style: GoogleFonts.poppins()),
                  subtitle: Text('Rp ${product['price'].toStringAsFixed(0)}',
                      style: GoogleFonts.poppins()),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Menu Option Cafe',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: kToolbarHeight + 20),
            itemCount: productData.length,
            itemBuilder: (context, index) {
              var product = productData[index];
              return OptionCard(
                uuid: product['uuid'],
                name: product['name'],
                price: product['price'],
                description: product['description'],
                stock: product['stock'],
                onToggle: (isChecked) =>
                    handleToggle(product['uuid'], isChecked),
              );
            },
          ),
          if (checkedItems.isNotEmpty)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  _showCheckedItems(context);
                },
                child: Text(
                  'View Cart (${checkedItems.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
              onPressed: () {
                // Navigate to next page or perform action
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> productData = [
    {
      'uuid': '1',
      'name': 'Americano (H/C)',
      'price': 25000,
      'description': 'Classic Americano coffee, hot or cold.',
      'stock': 10,
    },
    {
      'uuid': '2',
      'name': 'Caramel Latte (C)',
      'price': 30000,
      'description': 'Caramel flavored latte served cold.',
      'stock': 5,
    },
    {
      'uuid': '3',
      'name': 'Latte (H/C)',
      'price': 30000,
      'description': 'Smooth and creamy latte, hot or cold.',
      'stock': 8,
    },
    {
      'uuid': '4',
      'name': 'Kopi Susu Tiger (C)',
      'price': 32000,
      'description': 'Signature Kopi Susu with Tiger flavor, cold.',
      'stock': 12,
    },
    {
      'uuid': '5',
      'name': 'Kopi Aren Doppio (C)',
      'price': 35000,
      'description': 'Double shot of Kopi Aren, served cold.',
      'stock': 7,
    },
    {
      'uuid': '6',
      'name': 'Fresh Honey Lemon (H/C)',
      'price': 28000,
      'description': 'Refreshing honey lemon drink, hot or cold.',
      'stock': 9,
    },
    {
      'uuid': '7',
      'name': 'Honey Tea Latte (C)',
      'price': 30000,
      'description': 'Honey flavored tea latte, served cold.',
      'stock': 11,
    },
    {
      'uuid': '8',
      'name': 'Seasalt Caramel Oat Latte (C)',
      'price': 33000,
      'description': 'Oat latte with seasalt caramel, served cold.',
      'stock': 6,
    },
    {
      'uuid': '9',
      'name': 'Tiger Matcha Latte (H/C)',
      'price': 32000,
      'description': 'Matcha latte with Tiger flavor, hot or cold.',
      'stock': 10,
    },
    {
      'uuid': '10',
      'name': 'Tiger Salted Cocoa (C)',
      'price': 34000,
      'description': 'Salted cocoa with Tiger flavor, served cold.',
      'stock': 5,
    },
  ];
}
