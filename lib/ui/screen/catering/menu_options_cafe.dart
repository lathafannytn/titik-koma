import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_cubit.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_state.dart';
import 'package:tikom/data/models/drinks.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/ui/screen/catering/add_on.dart';
import 'card/option.dart';

class MenuOptionCafe extends StatefulWidget {
  final NewTransactionFullService newTransactionFullService;
  MenuOptionCafe({required this.newTransactionFullService});

  @override
  _MenuOptionCafeState createState() => _MenuOptionCafeState();
}

class _MenuOptionCafeState extends State<MenuOptionCafe> {
  List<List<String>> checkedItems = [];
  late BundleCubit _bundleCubit;
  List<Drinks> productData = [];

  @override
  void initState() {
    // get bundle id
    String? package_full = widget.newTransactionFullService.package;
    var split_package = package_full!.split('//');

    _bundleCubit = BundleCubit()
      ..loadBundleProduct(int.parse(split_package[0]));

    // a
    _bundleCubit.stream.listen((state) {
      print('masuk');
      if (state is BundleSuccess) {
        setState(() {
          for (int i = 0; i < state.bundle[0].drinks!.length; i++) {
            productData.add(state.bundle[0].drinks![i]);
          }
        });

        print(productData);
      }
    });
    super.initState();
  }

  void handleToggle(String name, String uuid, bool isChecked, String type) {
    setState(() {
      if (isChecked) {
        checkedItems.add([name, uuid, type]);
      } else {
        print('remove');
        // checkedItems.remove([name, uuid, type]);
         checkedItems.removeWhere((item) => item[1] == uuid);
      }
      print('checked item');
      print(checkedItems);
    });
  }

  void _showCheckedItems(BuildContext context) {
    print(productData);
    // var checkedProducts = productData
    //     .where((product) => checkedItems.contains(product.uuid))
    //     .toList();
    var checkedProducts = productData.where((product) {
      return checkedItems.any((item) => item[1] == product.uuid);
    }).toList();
    // print(checkedProducts2);
    print(productData);
    print('checked products');
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
              const SizedBox(height: 8),
              ...checkedProducts.map((product) {
                return ListTile(
                  title: Text(product.name, style: GoogleFonts.poppins()),
                  subtitle: Text('Rp ${product.price.toStringAsFixed(0)}',
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
      body: BlocBuilder<BundleCubit, BundleState>(
        bloc: _bundleCubit,
        builder: (context, state) {
          if (state is BundleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BundleFailure) {
            return Center(child: Text(state.message));
          }
          if (state is BundleSuccess) {
            print('data');
            print(state.bundle.length);
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(top: kToolbarHeight + 20),
                  itemCount: state.bundle[0].drinks?.length,
                  itemBuilder: (context, index) {
                    var product = state.bundle[0].drinks?[index];
                    return OptionCard(
                      uuid: product?.uuid,
                      name: product?.name,
                      price: product?.price,
                      description: product?.desc,
                      stock: product?.stock,
                      imagePath: product?.imgUrl,
                      onSelectionChanged: (isChecked, cupSize) {
                        handleToggle(
                            product?.name, product?.uuid, isChecked, cupSize);
                        print('Toggled: $isChecked, Cup size: $cupSize');
                      },
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
                      print(checkedItems);
                      NewTransactionFullService newTransFullService =
                          NewTransactionFullService(
                              full_service:
                                  widget.newTransactionFullService.full_service,
                              package: widget.newTransactionFullService.package,
                              product_list: checkedItems);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdditionalExtrasScreen(
                                    newTransactionFullService:
                                        newTransFullService,
                                  )));
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // List<Map<String, dynamic>> productData = [
  //   {
  //     'uuid': '1',
  //     'name': 'Americano (H/C)',
  //     'price': 25000,
  //     'description': 'Classic Americano coffee, hot or cold.',
  //     'stock': 10,
  //   },
  //   {
  //     'uuid': '2',
  //     'name': 'Caramel Latte (C)',
  //     'price': 30000,
  //     'description': 'Caramel flavored latte served cold.',
  //     'stock': 5,
  //   },
  //   {
  //     'uuid': '3',
  //     'name': 'Latte (H/C)',
  //     'price': 30000,
  //     'description': 'Smooth and creamy latte, hot or cold.',
  //     'stock': 8,
  //   },
  //   {
  //     'uuid': '4',
  //     'name': 'Kopi Susu Tiger (C)',
  //     'price': 32000,
  //     'description': 'Signature Kopi Susu with Tiger flavor, cold.',
  //     'stock': 12,
  //   },
  //   {
  //     'uuid': '5',
  //     'name': 'Kopi Aren Doppio (C)',
  //     'price': 35000,
  //     'description': 'Double shot of Kopi Aren, served cold.',
  //     'stock': 7,
  //   },
  //   {
  //     'uuid': '6',
  //     'name': 'Fresh Honey Lemon (H/C)',
  //     'price': 28000,
  //     'description': 'Refreshing honey lemon drink, hot or cold.',
  //     'stock': 9,
  //   },
  //   {
  //     'uuid': '7',
  //     'name': 'Honey Tea Latte (C)',
  //     'price': 30000,
  //     'description': 'Honey flavored tea latte, served cold.',
  //     'stock': 11,
  //   },
  //   {
  //     'uuid': '8',
  //     'name': 'Seasalt Caramel Oat Latte (C)',
  //     'price': 33000,
  //     'description': 'Oat latte with seasalt caramel, served cold.',
  //     'stock': 6,
  //   },
  //   {
  //     'uuid': '9',
  //     'name': 'Tiger Matcha Latte (H/C)',
  //     'price': 32000,
  //     'description': 'Matcha latte with Tiger flavor, hot or cold.',
  //     'stock': 10,
  //   },
  //   {
  //     'uuid': '10',
  //     'name': 'Tiger Salted Cocoa (C)',
  //     'price': 34000,
  //     'description': 'Salted cocoa with Tiger flavor, served cold.',
  //     'stock': 5,
  //   },
  // ];
}
