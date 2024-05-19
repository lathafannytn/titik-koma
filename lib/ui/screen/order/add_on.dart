// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOnScreen extends StatefulWidget {
  @override
  _AddOnScreenState createState() => _AddOnScreenState();
}

class _AddOnScreenState extends State<AddOnScreen> {
  String _selectedOption = 'iced';
  String _selectedIceSize = 'Regular Ice';
  String _selectedIceCube = 'Normal Ice';
  String _selectedEspresso = 'Normal Shot';
  String _selectedSweetness = 'Normal Sweet';
  
  double _basePrice = 29000;
  double _additionalPrice = 0;

  void _updatePrice() {
    double additionalPrice = 0;

    if (_selectedIceSize == 'Large Ice') {
      additionalPrice += 6000;
    }

    if (_selectedEspresso == '+1 Shot') {
      additionalPrice += 6000;
    } else if (_selectedEspresso == '+2 Shot') {
      additionalPrice += 12000;
    }

    setState(() {
      _additionalPrice = additionalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Kopi Aren Doppio',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/kopi_aren_doppio.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 400.0,
                    width: double.infinity,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDescriptionText(), // Pindahkan buildDescriptionText di sini
                      SizedBox(height: 16),
                      buildSectionTitle('Pilihan Tersedia'),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          buildOptionContainer(
                            label: 'iced',
                            icon: Icons.local_drink,
                            isSelected: _selectedOption == 'iced',
                            onTap: () {
                              setState(() {
                                _selectedOption = 'iced';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          buildOptionContainer(
                            label: 'hot',
                            icon: Icons.local_cafe,
                            isSelected: _selectedOption == 'hot',
                            onTap: () {
                              setState(() {
                                _selectedOption = 'hot';
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      buildSectionTitle('Ukuran Cup'),
                      SizedBox(height: 8),
                      buildRadioListTile(
                        title: 'Regular Ice',
                        value: 'Regular Ice',
                        groupValue: _selectedIceSize,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceSize = value!;
                            _updatePrice();
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: 'Large Ice (+Rp 6.000)',
                        value: 'Large Ice',
                        groupValue: _selectedIceSize,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceSize = value!;
                            _updatePrice();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildSectionTitle('Ice Cube'),
                      SizedBox(height: 8),
                      buildRadioListTile(
                        title: 'Normal Ice',
                        value: 'Normal Ice',
                        groupValue: _selectedIceCube,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceCube = value!;
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: 'Less Ice',
                        value: 'Less Ice',
                        groupValue: _selectedIceCube,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceCube = value!;
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: 'More Ice',
                        value: 'More Ice',
                        groupValue: _selectedIceCube,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceCube = value!;
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: 'No Ice',
                        value: 'No Ice',
                        groupValue: _selectedIceCube,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceCube = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildSectionTitle('Espresso'),
                      SizedBox(height: 8),
                      buildRadioListTile(
                        title: 'Normal Shot',
                        value: 'Normal Shot',
                        groupValue: _selectedEspresso,
                        onChanged: (value) {
                          setState(() {
                            _selectedEspresso = value!;
                            _updatePrice();
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: '+1 Shot (+Rp 6.000)',
                        value: '+1 Shot',
                        groupValue: _selectedEspresso,
                        onChanged: (value) {
                          setState(() {
                            _selectedEspresso = value!;
                            _updatePrice();
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: '+2 Shot (+Rp 12.000)',
                        value: '+2 Shot',
                        groupValue: _selectedEspresso,
                        onChanged: (value) {
                          setState(() {
                            _selectedEspresso = value!;
                            _updatePrice();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      buildSectionTitle('Sweetness'),
                      SizedBox(height: 8),
                      buildRadioListTile(
                        title: 'Normal Sweet',
                        value: 'Normal Sweet',
                        groupValue: _selectedSweetness,
                        onChanged: (value) {
                          setState(() {
                            _selectedSweetness = value!;
                          });
                        },
                      ),
                      buildRadioListTile(
                        title: 'Less Sweet',
                        value: 'Less Sweet',
                        groupValue: _selectedSweetness,
                        onChanged: (value) {
                          setState(() {
                            _selectedSweetness = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline, color: Color.fromARGB(255, 20, 63, 49)),
                        onPressed: () {},
                      ),
                      Text(
                        '1',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Color.fromARGB(255, 20, 63, 49)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 20, 63, 49),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Tambah - Rp ${_basePrice + _additionalPrice}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildDescriptionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Iced Buttercream Latte',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Nikmatnya Buttercream Coffee sebagai topping kopi susu karamel',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Rp 29.000',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Divider(
          color: Colors.grey[200],
          thickness: 4,
        ),
      ],
    );
  }

  Widget buildOptionContainer({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.0, 
        height: 80.0,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Color.fromARGB(255, 20, 63, 49) : Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? Colors.green[50] : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: isSelected ? Color.fromARGB(255, 20, 63, 49) : Colors.black,
            ),
            SizedBox(height: 4.0),
            Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  color: isSelected ? Color.fromARGB(255, 20, 63, 49) : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioListTile({
    required String title,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Color.fromARGB(255, 20, 63, 49),
    );
  }
}
