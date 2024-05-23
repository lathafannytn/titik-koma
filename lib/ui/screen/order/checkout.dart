import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tikom/ui/screen/order/add_on.dart';
import 'package:tikom/ui/screen/product/drinks_menu.dart';
import '../voucher/voucher_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutScreen(),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Color customGreen = Color.fromARGB(255, 30, 83, 66);
  bool usePoints = true;
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
              SizedBox(height: 16),
              isPickup
                  ? buildPickupDetails(context)
                  : buildDeliveryDetails(context),
              SizedBox(height: 16),
              buildOrderDetails(context),
              SizedBox(height: 16),
              buildDiscountSection(context),
              SizedBox(height: 16),
              buildPaymentMethod(context),
              SizedBox(height: 16),
              buildPaymentOptions(context),
              SizedBox(height: 16),
              buildPaymentDetails(),
              SizedBox(height: 16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  // Navigate to DrinksMenuScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DrinksMenuPage()),
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
                            color: customGreen, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'assets/images/kopi_aren_doppio.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1x Classic Brew',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to AddOnPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddOnScreen(
                                        uuid: '',
                                      )),
                            );
                          },
                          child: Icon(Icons.edit, size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      'Hot',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Base Price: \$3.50\nSize (Grande): +\$0.50\n1 x Skim Milk: +\$0.50\n1 x Hazelnut: +\$1.00\n1 x Crumble: +\$0.50',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Subtotal: \$6.00',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Notes',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Text(
            'Less sugar please.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_offer, color: customGreen),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: customGreen,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'XGZ9V2',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            // Add your remove discount logic here
                          },
                          child:
                              Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to voucher page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VoucherPage()),
                  );
                },
                child:
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ],
          ),
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
                        '200 Points',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '100 points equals \$1.00',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Switch(
                value: usePoints,
                onChanged: (bool value) {
                  setState(() {
                    usePoints = value;
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

  Widget buildPaymentOptions(BuildContext context) {
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
          SizedBox(height: 16),
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
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  'Down Payment Amount: \$3.00',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          if (_selectedPaymentOption == PaymentOption.fullPayment)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  'Full Payment Amount: \$6.00',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildPaymentDetails() {
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
            'Payment Details',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Subtotal',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Text(
                '\$6.00',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Service Fee',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Text(
                '\$1.00',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Text(
                '-\$1.80',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          if (usePoints)
            Column(
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '200 Points Used',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text(
                      '-\$2.00',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payment',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                usePoints
                    ? '\$3.20'
                    : '\$5.20', // Adjust total based on points usage
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPlaceOrderButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Place order action
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
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

enum PaymentOption { downPayment, fullPayment }
