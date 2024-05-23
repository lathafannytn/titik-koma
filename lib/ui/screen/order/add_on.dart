import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_cubit.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';

class AddOnScreen extends StatefulWidget {
  final String uuid;
  const AddOnScreen({Key? key, required this.uuid}) : super(key: key);

  @override
  _AddOnScreenState createState() => _AddOnScreenState();
}

class _AddOnScreenState extends State<AddOnScreen> {
  ProductDetailDataCubit? _productDetailDataCubit;

  String productName = '';
  String productImage = '';

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
  void initState() {
    super.initState();
    _productDetailDataCubit = BlocProvider.of<ProductDetailDataCubit>(context);
    _productDetailDataCubit?.loadProductDetailData(widget.uuid);
    _productDetailDataCubit?.stream.listen((state) {
      if (state is ProductDetailDataLoaded) {
        setState(() {
          productName = state.productDetail.name;
          productImage = state.productDetail.image;
        });
      }
    });
  }

  @override
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
                    productName,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(productImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 400.0,
                    width: double.infinity,
                  ),
                ),
              ),
              BlocListener<ProductDetailDataCubit, ProductDetailDataState>(
                listener: (context, state) {
                  if (state is ProductDetailDataError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                },
                child:
                    BlocBuilder<ProductDetailDataCubit, ProductDetailDataState>(
                  builder: (context, state) {
                    if (state is ProductDetailDataLoading) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ProductDetailDataLoaded) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            buildDescriptionText(state.productDetail.name,
                                state.productDetail.description),
                            buildOptions(),
                            buildPrice(),
                          ],
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(child: Text('Unexpected state')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomBar(),
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionText(String name, String description) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Rp 10',
            style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey[200],
            thickness: 4,
          ),
        ],
      ),
    );
  }

  Widget buildProductDetails() {
    // Customize this widget to show the product details
    return Container();
  }

  Widget buildOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  Widget buildOptionContainer({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
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
    );
  }

  Widget buildPrice() {
    double totalPrice = _basePrice + _additionalPrice;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey[200],
            thickness: 4,
          ),
          SizedBox(height: 8),
          Text(
            'Total Harga',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rp ${totalPrice.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rp ${(_basePrice + _additionalPrice).toStringAsFixed(0)}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              // ignore: sort_child_properties_last
              child: Text(
                'Add to Cart',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
