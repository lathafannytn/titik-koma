import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final num price;
  final String imagePath;

  ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(imagePath, fit: BoxFit.cover),
          ),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('\$${price.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}


