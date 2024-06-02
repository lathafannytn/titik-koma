import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tikom/class/card/product/product_card.dart';
import 'package:tikom/common/shared_pref.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_cubit.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_order_product/fetch_order_product_cubit.dart';
import 'package:tikom/data/blocs/fetch_order_product/fetch_order_product_state.dart';
import 'package:tikom/data/repository/order_repository.dart';
import 'package:tikom/ui/screen/order/checkout.dart';
import 'package:tikom/utils/storage_service.dart';

import '../../../data/models/drinks.dart';
import 'category.dart';

class DrinksMenuPage extends StatefulWidget {
  @override
  _DrinksMenuPageState createState() => _DrinksMenuPageState();
}

class _DrinksMenuPageState extends State<DrinksMenuPage> {
  late OrderDataCubit _orderDataCubit;
  late OrderProductCubit _orderProductCubit;
  int total_price = 0;
  int total_quantity = 0;
  List<Category> categories = [];
  List<Drinks> drinks = [];

  int currentSelected = 0;
  String uuidCategory = "";
  String token = StorageService.getToken('token');
  bool isPickupSelected = true;

  @override
  void initState() {
    super.initState();
    _orderDataCubit = OrderDataCubit()..loadOrderData();
    _orderProductCubit = OrderProductCubit()..loadOrderProduct();

    _orderDataCubit.stream.listen((state) {
      if (state is OrderDataSuccess) {
        setState(() {
          total_price = state.categories[0].total_price;
          total_quantity = state.categories[0].total_quantity;
        });
      }
    });
    fetchCategories().then((data) {
      setState(() {
        categories = data as List<Category>;
        if (categories.isNotEmpty) {
          uuidCategory = categories[0].uuid;
        }
      });
    });
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('https://titik-koma.givenjeremia.com/api/product/category'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final List<Category> categories = [];
        final responseData = json.decode(response.body)['data'];
        if (responseData != null) {
          for (var categoryData in responseData) {
            categories.add(Category.fromJson(categoryData));
          }
        }
        return categories;
      } else {
        throw Exception(
            'Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server Category: $e');
    }
  }

  Future<List<Drinks>> fetchDrinksByCategory(String uuid) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://titik-koma.givenjeremia.com/api/product/category/$uuid'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final List<Drinks> drinks = [];
        final decodedBody = json.decode(response.body);
        final responseData = decodedBody['data'];
        if (responseData != null && responseData is List) {
          for (var drinkData in responseData) {
            drinks.add(Drinks.fromJson(drinkData));
          }
        } else {
          throw Exception('Invalid response data format');
        }
        return drinks;
      } else {
        throw Exception(
            'Failed to load drinks with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  void handleShowOrder() {}

  void handleDelete(String uuid) {}

  Future<void> handlePlusMinus(String uuid, String actions) async {
    print(actions);
    try {
      final OrderRepository _OrderRepository = OrderRepository();
      final response =
          await _OrderRepository.plusMinus(uuid: uuid, action: actions);
      print('from handle');
      print(response);
      _orderProductCubit.loadOrderProduct();
      _orderDataCubit.loadOrderData();
      _orderDataCubit.stream.listen((state) {
        if (state is OrderDataSuccess) {
          setState(() {
            total_price = state.categories[0].total_price;
            total_quantity = state.categories[0].total_quantity;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCategories() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            categories.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  currentSelected = index;
                  uuidCategory = categories[index].uuid;
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                color: currentSelected == index ? Colors.white : Colors.transparent,
                child: Column(
                  children: [
                    if (currentSelected == index) ...[
                      Icon(Icons.local_cafe, color: Colors.orange),
                      SizedBox(height: 4),
                      Text(
                        categories[index].name,
                        style: GoogleFonts.poppins(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ] else
                      Text(
                        categories[index].name,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _orderDataCubit,
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPickupSelected = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isPickupSelected ? Colors.white : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Pickup',
                              style: TextStyle(
                                fontWeight: isPickupSelected ? FontWeight.bold : FontWeight.normal,
                                color: isPickupSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPickupSelected = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: !isPickupSelected ? Colors.white : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Delivery',
                              style: TextStyle(
                                fontWeight: !isPickupSelected ? FontWeight.bold : FontWeight.normal,
                                color: !isPickupSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    color: Colors.orange[100],
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '[NEW] - DISKON ONGKIR MAX 100% SETIAP HARI',
                      style: GoogleFonts.poppins(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // Sidebar Kategori
                  Container(
                    width: 70,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Expanded(child: _buildCategories()),
                      ],
                    ),
                  ),
                  // Konten Scrollable
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return FutureBuilder<List<Drinks>>(
                                future: fetchDrinksByCategory(uuidCategory),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        "Error: ${snapshot.error}",
                                        style: GoogleFonts.poppins(),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return ListView.builder(
                                      padding: EdgeInsets.all(16),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var drink = snapshot.data![index];
                                        return ProductCard(
                                          name: drink.name,
                                          price: drink.price,
                                          imagePath: drink.imgUrl,
                                          uuid: drink.uuid,
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        "No data available",
                                        style: GoogleFonts.poppins(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder(
          bloc: _orderDataCubit,
          builder: (context, state) {
            if (state is OrderDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrderDataSuccess) {
              if (state.categories.length > 0) {
                return BottomAppBar(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Icon(Icons.shopping_bag,
                                      color: Color.fromARGB(255, 9, 76, 58),
                                      size: 30),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: Text(
                                        "${state.categories[0].total_quantity}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Rp. ${state.categories[0].total_price}",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showBottomSheet(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 9, 76, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Checkout", style: GoogleFonts.poppins()),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            if (state is OrderDataFailure) {
              print('error');
              print(state.message);
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: BlocBuilder<OrderProductCubit, OrderProductState>(
                bloc: _orderProductCubit,
                builder: (context, state) {
                  if (state is OrderProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is OrderProductSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: state.order.length,
                            itemBuilder: (context, index) {
                              var data = state.order[index];
                              return ListTile(
                                title: Text(data.product_detail.name,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.selected,
                                        style: GoogleFonts.poppins()),
                                    Text(data.add_on_product,
                                        style: GoogleFonts.poppins()),
                                  ],
                                ),
                                leading: Image.network(data.product_detail.image),
                                trailing: Container(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          handlePlusMinus(data.uuid, 'MINUS');
                                        },
                                        icon: Icon(Icons.remove_circle_outline,
                                            color: Color.fromARGB(255, 9, 76, 58)),
                                      ),
                                      Text('${data.total_quantity}',
                                          style: GoogleFonts.poppins(fontSize: 16)),
                                      IconButton(
                                        onPressed: () {
                                          handlePlusMinus(data.uuid, 'PLUS');
                                        },
                                        icon: Icon(Icons.add_circle_outline,
                                            color: Color.fromARGB(255, 9, 76, 58)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Total: Rp $total_price',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                          trailing: ElevatedButton(
                            onPressed: total_quantity < 10 ? null : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                          uuid: state.order[0].uuid, count: total_quantity,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 9, 76, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Checkout", style: GoogleFonts.poppins()),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is OrderProductFailure) {
                    print('error');
                    print(state.message);
                  }
                  return SizedBox();
                },
              ),
            );
          },
        );
      },
    );
  }
}
