import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_cubit.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_order_product/fetch_order_product_cubit.dart';
import 'package:tikom/data/blocs/fetch_order_product/fetch_order_product_state.dart';
import 'package:tikom/data/blocs/transaction/transaction_bloc.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/screen/order/add_on.dart';
import 'package:tikom/ui/screen/product/drinks_menu.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import '../voucher/voucher_page.dart';

import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/ui/widgets/loading_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  final String uuid;
  const CheckoutScreen({Key? key, required this.uuid}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late OrderDataCubit _orderDataCubit;
  late UserDataCubit _userDataCubit;
  late TransactionBloc _transactionBloc;

  int total_price = 0;
  int default_price = 0;
  int payment_option = 0;
  int price_discount = 0;

  String point = '';
  late List voucher = [];

  final Color customGreen = Color.fromARGB(255, 30, 83, 66);
  bool usePoints = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
  bool isPickup = true; // Toggle state
  PaymentOption _selectedPaymentOption = PaymentOption.fullPayment;
  bool isPickupNowSelected = true;
  DateTime selectedPickupDate = DateTime.now();
  TimeOfDay selectedPickupTime = TimeOfDay(hour: 12, minute: 0);

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  String getFormattedDateTime() {
    final DateFormat dateFormatter = DateFormat('MMM dd yyyy');
    final String date = dateFormatter.format(selectedDate);
    final String time = selectedTime.format(context);
    return '$time, $date';
  }

  void _showPickupTimeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isPickupNow = true;

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Choose pick up time',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPickupNow = true;
                      });
                      Navigator.pop(context);
                      this.setState(() {
                        isPickupNowSelected = true;
                        selectedDate = DateTime.now();
                        selectedTime = TimeOfDay.now();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            isPickupNow ? Border.all(color: customGreen) : null,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: customGreen, size: 30),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pick up now',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                'Estimated ready in 15 mins.',
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPickupNow = false;
                      });
                      Navigator.pop(context);
                      _showPickUpLaterDialog(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: !isPickupNow
                            ? Border.all(color: customGreen)
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: customGreen, size: 30),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pick up later',
                                  style: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Set your pick up time.',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: customGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPickUpLaterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Set your pick up time',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    DateFormat('EEEE, MMM d, yyyy').format(selectedDate),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          initialTimerDuration: Duration(
                            hours: selectedTime.hour,
                            minutes: selectedTime.minute,
                          ),
                          onTimerDurationChanged: (Duration newDuration) {
                            setState(() {
                              selectedTime = TimeOfDay(
                                hour: newDuration.inHours,
                                minute: newDuration.inMinutes % 60,
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: customGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      this.setState(() {
                        isPickupNowSelected = false;
                      });
                    },
                    child: Text(
                      'Set Time',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  @override
  void initState() {
    super.initState();
    _transactionBloc = TransactionBloc();
    _orderDataCubit = OrderDataCubit()..loadOrderData();
    _userDataCubit = UserDataCubit()..loadUserData();
    // print(_orderDataCubit);

    _orderDataCubit.stream.listen((state) {
      if (state is OrderDataSuccess) {
        setState(() {
          total_price = state.categories[0].total_price;
          default_price = state.categories[0].total_price;
          payment_option = state.categories[0].total_price;
        });
      }
    });

    _userDataCubit.stream.listen((state) {
      print('masuk');
      if (state is UserDataLoaded) {
        setState(() {
          point = state.user.point;
        });
      }
    });
  }

    void handlePlaceOrder() {
    try {
      var data_voucher = voucher.length > 0 ? voucher[0][0] : '-';
      var data_payment_type = 'Virtual BCA';

      var data_use_point = usePoints ? 'yes' : '-';
      var data_price = total_price;
      AppExt.hideKeyboard(context);
      DialogTemp().Konfirmasi(
        context: context,
        onYes: () {
          LoadingDialog.show(context, barrierColor: const Color(0xFF777C7E));
          print('Handle Place Order Runn');
          _transactionBloc.add(TransactionButtonPressed(
              price: default_price,
              payment_type: data_payment_type,
              voucher: data_voucher,
              use_point: data_use_point));
        },
        title: "Apakah Ingin Checkout?",
        onYesText: 'Ya',
      );
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back
          },
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPickupDeliveryToggle(),
              const SizedBox(height: 16),
              isPickup
                  ? buildPickupDetails(context)
                  : buildDeliveryDetails(context),
              const SizedBox(height: 16),
              buildOrderDetails(context),
              const SizedBox(height: 16),
              buildDiscountSection(context),
              // SizedBox(height: 16),
              // buildPaymentMethod(context),
              const SizedBox(height: 16),
              buildPaymentOptions(),
              const SizedBox(height: 16),
              buildPaymentDetails(),
              const SizedBox(height: 16),
              buildPlaceOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPickupDeliveryToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPickup = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isPickup ? Colors.white : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Pick up',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isPickup ? customGreen : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPickup = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !isPickup ? Colors.white : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Delivery',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !isPickup ? customGreen : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPickupDetails(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPickupTimeDialog(context);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isPickupNowSelected
                      ? 'Pick up now at ${DateFormat('MMM dd yyyy').format(selectedPickupDate)}'
                      : 'Pick up at ${getFormattedDateTime()}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Take your order at:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: customGreen),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Titikkoma Adijasa',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '3.8 km from your location',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryDetails(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your order is delivered from:',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.store, color: customGreen),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Caffely Astoria Aromas',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '350 5th Ave, New York, NY 10118, USA',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '1.2 km from your location',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 8),
              Text(
                'To your address:',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.home, color: customGreen),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '701 7th Ave, New York, NY 10036, USA',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '5 minutes estimate arrived',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        buildDeliveryOption(),
      ],
    );
  }

  Widget buildDeliveryOption() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'assets/images/kopi_aren_doppio.jpg', // Path gambar logo DoorDash
                width: 32,
                height: 32,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'DoorDash Drive',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOrderDetails(BuildContext context) {
    return BlocBuilder<OrderProductCubit, OrderProductState>(
      bloc: OrderProductCubit()..loadOrderProduct(),
      builder: (context, state) {
        if (state is OrderProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OrderProductSuccess) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Details',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Navigate to DrinksMenuScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrinksMenuPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: customGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: customGreen),
                          Text(
                            'Add more',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: customGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Data
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.order.map((item) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              item.product_detail.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item.total_quantity} x ${item.product_detail.name}',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate to AddOnPage
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           AddOnScreen(
                                          //             uuid: '',
                                          //           )),
                                          // );
                                        },
                                        child: const Icon(Icons.edit,
                                            size: 16, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item.selected,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    item.add_on_product,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Harga Rp. ${item.total_price}',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Subtotal: Rp. $default_price',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 16),
                // Text(
                //   'Notes',
                //   style: GoogleFonts.poppins(
                //     textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                //   ),
                // ),
                // Text(
                //   'Less sugar please.',
                //   style: GoogleFonts.poppins(
                //     textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                //   ),
                // ),
              ],
            ),
          );
        }
        if (state is OrderProductFailure) {
          print('error');
          print(state.message);
        }
        return SizedBox();
      },
    );
  }

  Widget buildDiscountSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Discount',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              List<String> data = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VoucherPage()),
              );
              print(data);
              if (data != null) {
                setState(() {
                  // voucher.clear();
                  voucher.add(data);
                  var percentage = double.parse(voucher[0][2]) / 100;

                  double price_discountData = total_price * percentage;

                  double discounted_price = total_price - price_discountData;
                  int discounted_price2 = discounted_price.round();

                  price_discount = price_discountData.round();
                  // print("Final Price: $finalPrice");
                  total_price -= price_discount;
                  payment_option -= price_discount;
                });

                print(voucher);
              }
            },
            child: Row(
              children: [
                Icon(Icons.local_offer, color: customGreen),
                const SizedBox(width: 8),
                Text(
                  'My Voucher',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          if (voucher.isNotEmpty) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: customGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        voucher[0][1],
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            voucher.clear();
                            total_price += price_discount;
                            payment_option += price_discount;
                            price_discount = 0;
                          });
                        },
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          // const Divider(color: Colors.grey, height: 32),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Icon(Icons.local_offer, color: customGreen),
          //         const SizedBox(width: 8),
          //         Container(
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //           decoration: BoxDecoration(
          //             color: customGreen,
          //             borderRadius: BorderRadius.circular(16),
          //           ),
          //           child: Row(
          //             children: [
          //               Text(
          //                 'XGZ9V2',
          //                 style: GoogleFonts.poppins(
          //                   textStyle: const TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //               ),
          //               const SizedBox(width: 4),
          //               GestureDetector(
          //                 onTap: () {
          //                   // Add your remove discount logic here
          //                 },
          //                 child: const Icon(Icons.close,
          //                     color: Colors.white, size: 16),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     // GestureDetector(
          //     //   onTap: () async {
          //     //     List<String> data = await Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(builder: (context) => VoucherPage()),
          //     //     );
          //     //     if (data != null) {
          //     //       setState(() {
          //     //         voucher.add(data);
          //     //       });

          //     //       print(voucher);
          //     //     }
          //     //   },
          //     //   child: const Icon(Icons.arrow_forward_ios,
          //     //       size: 16, color: Colors.grey),
          //     // ),
          //   ],
          // ),
          Divider(color: Colors.grey, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.attach_money, color: customGreen),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$point Points',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   '100 points equals \$1.00',
                      //   style: GoogleFonts.poppins(
                      //     textStyle: TextStyle(color: Colors.grey),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              Switch(
                value: usePoints,
                onChanged: (bool value) {
                  setState(() {
                    usePoints = value;
                    if (value) {
                      total_price -= int.parse(point);
                      payment_option -= int.parse(point);
                    } else {
                      total_price += int.parse(point);
                      payment_option += int.parse(point);
                    }
                  });
                },
                activeColor: customGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPaymentMethod(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your navigation logic here to go to the payment method selection page
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet,
                    color: customGreen, size: 32),
                SizedBox(width: 8),
                Text(
                  'My Wallet',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$948.50',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOptions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Options',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ListTile(
                title: Text(
                  'Down Payment (50%)',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                leading: Radio(
                  value: PaymentOption.downPayment,
                  groupValue: _selectedPaymentOption,
                  onChanged: (PaymentOption? value) {
                    setState(() {
                      _selectedPaymentOption = value!;
                      payment_option = (total_price / 2).round();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'Full Payment',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                leading: Radio(
                  value: PaymentOption.fullPayment,
                  groupValue: _selectedPaymentOption,
                  onChanged: (PaymentOption? value) {
                    setState(() {
                      _selectedPaymentOption = value!;
                      payment_option = total_price;
                    });
                  },
                ),
              ),
            ],
          ),
          if (_selectedPaymentOption == PaymentOption.downPayment)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  'Down Payment Amount:  Rp. $payment_option',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          if (_selectedPaymentOption == PaymentOption.fullPayment)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  'Full Payment Amount: Rp. $payment_option',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildPaymentDetails() {
    return BlocBuilder<OrderDataCubit, OrderDataState>(
      bloc: _orderDataCubit,
      builder: (context, state) {
        if (state is OrderDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OrderDataSuccess) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Details',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Subtotal',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text(
                      'Rp. ${state.categories[0].total_price}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Service Fee',
                //       style: GoogleFonts.poppins(
                //         textStyle: const TextStyle(color: Colors.grey),
                //       ),
                //     ),
                //     Text(
                //       'Rp. 10000',
                //       style: GoogleFonts.poppins(
                //         textStyle: const TextStyle(color: Colors.grey),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text(
                      '-Rp. $price_discount',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                if (usePoints)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$point Points Used',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Text(
                            '-Rp $point',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Rp. ${usePoints ? total_price : payment_option}', // Adjust total based on points usage
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is OrderDataFailure) {
          print('error');
          print(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget buildPlaceOrderButton(BuildContext context) {
    return BlocProvider(
      create: (context) => _transactionBloc,
      child: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionSuccess) {
              AppExt.popScreen(context);
              DialogTemp().Informasi(
                  context: context,
                  onYes: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  tabIndex: 2,
                                )));
                  },
                  onYesText: 'Oke',
                  title: 'Berhasil Melakukan Order');
            } else if (state is TransactionFailure) {
              AppExt.popScreen(context);
              DialogTemp().Informasi(
                  context: context,
                  onYes: () {
                    Navigator.pop(context);
                  },
                  onYesText: 'Oke',
                  title: 'Gagal Melakukan Order');
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Place order action
                handlePlaceOrder();
              },
              style: ElevatedButton.styleFrom(
                primary: customGreen,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Place Order',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          )),
    );
  }
}

enum PaymentOption { downPayment, fullPayment }
