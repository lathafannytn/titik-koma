import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_add_on_product/add_on_product_cubit.dart';
import 'package:tikom/data/blocs/fetch_add_on_product/add_on_product_state.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_cubit.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/blocs/order/order_bloc.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/ui/widgets/loading_dialog.dart';

class AddOnScreen extends StatefulWidget {
  final String uuid;
  const AddOnScreen({Key? key, required this.uuid}) : super(key: key);

  @override
  _AddOnScreenState createState() => _AddOnScreenState();
}

class _AddOnScreenState extends State<AddOnScreen> {
  ProductDetailDataCubit? _productDetailDataCubit;
  late AddOnProductDataCubit _addOnProductDataCubit,
      _addOnProductIceLevelDataCubit,
      _addOnProductSugarDataCubit;

  late OrderBloc _orderBloc;

  String productName = '';
  String productImage = '';

  String _selectedOption = 'iced';
  String _selectedIceSize = 'Regular Ice';
  String _selectedIceCube = 'Normal Ice';
  String _selectedEspresso = 'Normal Shot';
  String _selectedSweetness = 'Normal Sweet';

  int _basePrice = 0;
  double _additionalPrice = 0;

  // void _updatePrice() {
  //   double additionalPrice = 0;

  //   if (_selectedIceSize == 'Large Ice') {
  //     additionalPrice += 6000;
  //   }

  //   if (_selectedEspresso == '+1 Shot') {
  //     additionalPrice += 6000;
  //   } else if (_selectedEspresso == '+2 Shot') {
  //     additionalPrice += 12000;
  //   }

  //   setState(() {
  //     _additionalPrice = additionalPrice;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _orderBloc = OrderBloc();
    // Add On

    _addOnProductDataCubit = AddOnProductDataCubit()..loadCupSizeData();
    _addOnProductIceLevelDataCubit = AddOnProductDataCubit()
      ..loadIceLevelData();

    _addOnProductSugarDataCubit = AddOnProductDataCubit()..loadSugarData();

    _productDetailDataCubit = BlocProvider.of<ProductDetailDataCubit>(context);
    _productDetailDataCubit?.loadProductDetailData(widget.uuid);
    _productDetailDataCubit?.stream.listen((state) {
      if (state is ProductDetailDataLoaded) {
        setState(() {
          productName = state.productDetail.name;
          productImage = state.productDetail.image;

          _basePrice = state.productDetail.price as int;
        });
      }
    });
  }

  void _handlerCheckout() {
    print('checkout Btn');
    double total = _basePrice + _additionalPrice;
    List<String> product = [widget.uuid];
    String selected = _selectedOption;
    List<String> add_on = [
      _selectedIceSize,
      _selectedIceCube,
      _selectedSweetness
    ];

    try {
      AppExt.hideKeyboard(context);
      DialogTemp().Konfirmasi(
        context: context,
        onYes: () {
          LoadingDialog.show(context, barrierColor: Color(0xFF777C7E));
          _orderBloc.add(OrderButtonPressed(
              products: product,
              selected: selected,
              add_on: add_on,
              total: total));
        },
        title: "Apakah Ingin Menambahkan Keranjang?",
        onYesText: 'Ya',
      );
    } catch (e) {
      throw Exception('Error : $e');
    }
    print(selected);
    print(add_on);
  }

  void getOnProduct() {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _orderBloc,
        ),
        BlocProvider(
          create: (context) => _addOnProductDataCubit,
        ),
        BlocProvider(
          create: (context) => _addOnProductIceLevelDataCubit,
        ),
        BlocProvider(
          create: (context) => _addOnProductSugarDataCubit,
        ),
      ],
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            AppExt.popScreen(context);
            DialogTemp().Informasi(
                context: context,
                onYes: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage()));
                },
                onYesText: 'Oke',
                title: 'Berhasil Menambahkan Keranjang');
          } else if (state is OrderFailure) {
            AppExt.popScreen(context);
            final snackBar = SnackBar(
              content: Text('Login Failed: ${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
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
                          SnackBar(content: Text('Error: //${state.message}')),
                        );
                      }
                    },
                    child: BlocBuilder<ProductDetailDataCubit,
                        ProductDetailDataState>(
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
        ),
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
            'Rp $_basePrice',
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
    return Container();
  }

  Widget buildOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle('Pilihan Tersedia'),
          const SizedBox(height: 8),
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
              const SizedBox(width: 8),
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
          const SizedBox(height: 16),
          buildSectionTitle('Ukuran Cup'),
          const SizedBox(height: 8),
          BlocBuilder(
            bloc: _addOnProductDataCubit,
            builder: (context, state) {
              if (state is AddOnProductDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddOnProductDataSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in state.categories)
                      buildRadioListTile(
                        title: i.name,
                        value: i.uuid,
                        groupValue: _selectedIceSize,
                        onChanged: (value) {
                          setState(() {
                            _selectedIceSize = value!;
                            _additionalPrice += i.extraPrice;
                            // _updatePrice();
                          });
                        },
                      ),
                  ],
                );
              }
              if (state is AddOnProductDataFailure) {
                print('error');
                print(state.message);
              }
              return SizedBox();
            },
          ),
          const SizedBox(height: 16),
          buildSectionTitle('Ice Cube'),
          const SizedBox(height: 8),
          BlocBuilder(
            bloc: _addOnProductIceLevelDataCubit,
            builder: (context, state) {
              if (state is AddOnProductIceLevelDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddOnProductIceLevelDataSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in state.categories)
                      buildRadioListTile(
                          title: i.name,
                          value: i.uuid,
                          groupValue: _selectedIceCube,
                          onChanged: (value) {
                            setState(() {
                              _selectedIceCube = value!;
                              _additionalPrice += i.extraPrice;
                            });
                          }),
                  ],
                );
              }
              if (state is AddOnProductIceLevelDataFailure) {
                print('error');
                print(state.message);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          buildSectionTitle('Sweetness'),
          const SizedBox(height: 8),
          BlocBuilder(
            bloc: _addOnProductSugarDataCubit,
            builder: (context, state) {
              if (state is AddOnProductSugarDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddOnProductSugarDataSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in state.categories)
                      buildRadioListTile(
                        title: i.name,
                        value: i.uuid,
                        groupValue: _selectedSweetness,
                        onChanged: (value) {
                          setState(() {
                            _selectedSweetness = value!;
                            _additionalPrice += i.extraPrice;
                          });
                        },
                      ),
                  ],
                );
              }
              if (state is AddOnProductSugarDataFailure) {
                print('error');
                print(state.message);
              }
              return const SizedBox();
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
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 8),
          Text(
            'Total Harga',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
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
              onPressed: () {
                _handlerCheckout();
              },
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
