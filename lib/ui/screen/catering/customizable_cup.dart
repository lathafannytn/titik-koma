import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/catering/checkout.dart';
import 'package:tikom/data/models/transaction_full_service.dart';


class CustomizableCupScreen extends StatefulWidget {
  final double totalCost;
  final NewTransactionFullService newTransactionFullService;
  CustomizableCupScreen({required this.totalCost, required this.newTransactionFullService});

  @override
  _CustomizableCupScreenState createState() => _CustomizableCupScreenState();
}

class _CustomizableCupScreenState extends State<CustomizableCupScreen> {
  String? selectedCup;
  TextEditingController customTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customizeable Cup',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  CupCard(
                    imageUrl: 'assets/images/glass_custom.jpg',
                    title: 'Event',
                    isSelected: selectedCup == 'Event',
                    onSelect: () {
                      setState(() {
                        selectedCup = 'Event';
                      });
                    },
                  ),
                  CupCard(
                    imageUrl: 'assets/images/glass_custom.jpg',
                    title: 'Wedding',
                    isSelected: selectedCup == 'Wedding',
                    onSelect: () {
                      setState(() {
                        selectedCup = 'Wedding';
                      });
                    },
                  ),
                  CupCard(
                    imageUrl: 'assets/images/glass_custom.jpg',
                    title: 'Couple',
                    isSelected: selectedCup == 'Couple',
                    onSelect: () {
                      setState(() {
                        selectedCup = 'Couple';
                      });
                    },
                  ),
                  CupCard(
                    imageUrl: 'assets/images/glass_custom.jpg',
                    title: 'Religion',
                    isSelected: selectedCup == 'Religion',
                    onSelect: () {
                      setState(() {
                        selectedCup = 'Religion';
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: customTextController,
              decoration: InputDecoration(
                labelText: 'Custom Text : (don\'t use symbol & emoticon)',
                labelStyle: GoogleFonts.poppins(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                   NewTransactionFullService newTransFullService =
                      NewTransactionFullService(
                    full_service: widget.newTransactionFullService.full_service,
                    product: widget.newTransactionFullService.product,
                    add_on: widget.newTransactionFullService.add_on,
                    custom_cup_name: selectedCup,
                    custom_cup_notes: customTextController.text,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutServiceScreen(newTransactionFullService: newTransFullService,)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Add - Rp ${widget.totalCost.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CupCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  CupCard({
    required this.imageUrl,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
