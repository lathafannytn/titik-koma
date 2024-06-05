import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/ui/screen/catering/add_on.dart';

class MenuOptionsScreen extends StatefulWidget {
  @override
  _MenuOptionsScreenState createState() => _MenuOptionsScreenState();
}

class _MenuOptionsScreenState extends State<MenuOptionsScreen> {
  String? selectedDrink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Options',
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
            Text(
              'choose one of your favorite drinks for your happy day',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  MenuCard(
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar yang benar
                    title: 'Americano',
                    isSelected: selectedDrink == 'Americano',
                    onSelect: () {
                      setState(() {
                        selectedDrink = 'Americano';
                      });
                    },
                  ),
                  MenuCard(
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar yang benar
                    title: 'Kopi Susu Tiger',
                    isSelected: selectedDrink == 'Kopi Susu Tiger',
                    onSelect: () {
                      setState(() {
                        selectedDrink = 'Kopi Susu Tiger';
                      });
                    },
                  ),
                  MenuCard(
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar yang benar
                    title: 'Kopi Aren Doppio',
                    isSelected: selectedDrink == 'Kopi Aren Doppio',
                    onSelect: () {
                      setState(() {
                        selectedDrink = 'Kopi Aren Doppio';
                      });
                    },
                  ),
                  MenuCard(
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar yang benar
                    title: 'Latte',
                    isSelected: selectedDrink == 'Latte',
                    onSelect: () {
                      setState(() {
                        selectedDrink = 'Latte';
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdditionalExtrasScreen()));
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
                    'next',
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

class MenuCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  MenuCard({
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
                  child: Image.network(
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
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
