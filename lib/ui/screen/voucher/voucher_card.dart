import 'package:flutter/material.dart';

class VoucherCard extends StatelessWidget {
  final String title;
  final String description;
  final String expiryDate;
  final String discount;
  final Function()? onclick;

  const VoucherCard({
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.discount,
     this.onclick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Hingga $expiryDate",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            Column(
              children: [
                Text(
                  discount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 62, 169, 126),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onclick,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 62, 169, 126),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Pakai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
