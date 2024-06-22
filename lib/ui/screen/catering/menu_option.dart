import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_product_catering/product_catering_cubit.dart';
import 'package:tikom/data/blocs/fetch_product_catering/product_catering_state.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/ui/screen/catering/add_on.dart';

class MenuOptionsScreen extends StatefulWidget {
  const MenuOptionsScreen({required this.newTransactionFullService});

  final NewTransactionFullService newTransactionFullService;
  @override
  _MenuOptionsScreenState createState() => _MenuOptionsScreenState();
}

class _MenuOptionsScreenState extends State<MenuOptionsScreen> {
  String? selectedDrink;
  late ProductCateringCubit _productCateringCubit;
  @override
  void initState() {
    _productCateringCubit = ProductCateringCubit()..loadProductCatering();
    super.initState();
  }

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
      body: BlocBuilder<ProductCateringCubit, ProductCateringState>(
        bloc: _productCateringCubit,
        builder: (context, state) {
          if (state is ProductCateringLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductCateringSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'choose one of your favorite drinks for your happy day',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      children: [
                        for (var i = 0; i < state.drinks.length; i++) ...[
                          MenuCard(
                            imageUrl: state.drinks[i].imgUrl,
                            title: state.drinks[i].name,
                            description: state.drinks[i].desc,
                            isSelected: selectedDrink == state.drinks[i].uuid,
                            onSelect: () {
                              setState(() {
                                selectedDrink = state.drinks[i].uuid;
                              });
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: selectedDrink != null
                          ? () {
                              print('produc select');
                              print(selectedDrink);
                              NewTransactionFullService newTransFullService =
                                  NewTransactionFullService(
                                full_service: widget
                                    .newTransactionFullService.full_service,
                                product: selectedDrink,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdditionalExtrasScreen(
                                            newTransactionFullService:
                                                newTransFullService,
                                          )));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
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
            );
          }
          if (state is ProductCateringFailure) {
            print('error');
            print(state.message);
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onSelect;

  MenuCard({
    required this.imageUrl,
    required this.title,
    required this.description,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              ),
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