import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tikom/data/blocs/catering/catering_bloc.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_state.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_cubit.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_state.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_cubit.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_state.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/data/repository/transaction_repository.dart';
import 'package:tikom/ui/screen/catering/map.dart';
import 'package:tikom/ui/screen/order/payment_qris.dart';
import 'package:tikom/ui/screen/voucher/voucher.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/utils/constant.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/ui/widgets/loading_dialog.dart';

class CheckoutServiceScreen extends StatefulWidget {
  final NewTransactionFullService newTransactionFullService;
  final double totalCost;

  CheckoutServiceScreen(
      {required this.newTransactionFullService, required this.totalCost});
  @override
  State<CheckoutServiceScreen> createState() => _CheckoutServiceScreenState();
}

class _CheckoutServiceScreenState extends State<CheckoutServiceScreen> {
  String delivery_place = 'Pilih Alamat';
  String delivery_price = '';

  String full_service_name = '';

  late CateringBloc _catering_bloc;
  late BundleCubit _bundle_cubit;

  int disccount = 0;
  int default_price = 0;
  int point = 0;
  bool usePoints = false;

  int payment_option = 0;

  int base_delivery_id = 0;
  String base_delivery_name = '';
  String base_delivery_address = '';
  String base_delivery_price = '';
  String base_delivery_long = '';
  String base_delivery_lat = '';
  bool isPickupNowSelected = true;

  bool isSingleDate = true;

  PaymentOption _selectedPaymentOption = PaymentOption.fullPayment;

  int totalPrice = 0;

  List delivered = [];
  late List voucher = [];

  late FullServiceCubit _fullServiceCubit;
  late UserDataCubit _userDataCubit;
  DateTime selectedPickupDate = DateTime.now();
  TimeOfDay selectedPickupTime = TimeOfDay(hour: 12, minute: 0);
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);

  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 1)),
  );

  Future<void> _selectDate(BuildContext context) async {
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
  }

  String getFormattedDateTime() {
    final DateFormat dateFormatter = DateFormat('MMM dd yyyy');
    final String date = dateFormatter.format(selectedDate);
    final String time = selectedTime.format(context);
    return '$time, $date';
  }

  void handleBaseDelivery() async {
    print('panggil handler Base Delivery');
    try {
      final TransactionRepository transRepository = TransactionRepository();
      final response =
          await transRepository.showDeliveryBase(type: 'full_service');
      print('form base delivery');
      print(response);
      if (response.status == 'success') {
        setState(() {
          base_delivery_id = response.data.id;
          base_delivery_name = response.data.name;
          base_delivery_price = response.data.price.toString();
          base_delivery_address = response.data.address;
          base_delivery_long = response.data.long;
          base_delivery_lat = response.data.lat;
        });
      } else {}
    } catch (error) {
      print('error handrel base deliver');
      print(error.toString());
    }
  }

  void handlePlaceOrder() {
    try {
      var data_voucher = voucher.length > 0 ? voucher[0][0] : '-';
      var data_use_point = usePoints ? 'yes' : '-';
      var data_price = totalPrice;
      var dateSelected = selectedDate.toString().split(" ")[0];
      var timeSeleted = selectedTime;

      print(dateSelected);
      print(timeSeleted.hour);
      print('Handle Place Order ');
      print(selectedDateRange);
      var dateTimeSelected = '';
      if (isSingleDate) {
        dateTimeSelected =
            '$dateSelected ${timeSeleted.hour}:${timeSeleted.minute}';
      } else {
        var dateStart =
            DateFormat('yyyy-MM-dd').format(selectedDateRange.start);
        var dateEnd = DateFormat('yyyy-MM-dd').format(selectedDateRange.end);
        print(dateStart);
        print(dateEnd);
        dateTimeSelected =
            '$dateStart ${timeSeleted.hour}:${timeSeleted.minute}//$dateEnd ${timeSeleted.hour}:${timeSeleted.minute}';
      }
      print(dateTimeSelected);
      AppExt.hideKeyboard(context);
      DialogTemp().Konfirmasi(
        context: context,
        onYes: () {
          LoadingDialog.show(context, barrierColor: const Color(0xFF777C7E));
          print('Handle Place Order Runn');
          _catering_bloc.add(CateringBlocButtonPressed(
              service: widget.newTransactionFullService.full_service,
              price: totalPrice.toString(),
              custom_cup_name: widget.newTransactionFullService.custom_cup_name,
              custom_cup_note:
                  widget.newTransactionFullService.custom_cup_notes,
              base_delivery: base_delivery_id,
              service_date: dateTimeSelected,
              products: widget.newTransactionFullService.product,
              delivery_address: delivery_place,
              delivery_price: delivery_price,
              package: widget.newTransactionFullService.package,
              product_list: widget.newTransactionFullService.product_list,
              payment_type: 'QRIS',
              voucher: data_voucher,
              use_point: data_use_point,
              add_on: widget.newTransactionFullService.add_on!['barista']?[1] !=
                          '0' &&
                      widget.newTransactionFullService.add_on!['service']?[1] !=
                          ''
                  ? widget.newTransactionFullService.add_on!
                  : <String, List<String>>{}));
        },
        title: "Apakah Ingin Checkout?",
        onYesText: 'Ya',
      );
    } catch (e) {
      print(e.toString());
      DialogTemp().Informasi(
          context: context,
          onYes: () {
            Navigator.pop(context);
          },
          onYesText: 'Ya',
          title: 'Error');
    }
  }

  @override
  void initState() {
    super.initState();
    handleBaseDelivery();
    _catering_bloc = CateringBloc();
    print('cek');
    print(widget.newTransactionFullService.package);
    // Default Price
    _fullServiceCubit = FullServiceCubit()..loadFullService();
    _fullServiceCubit.stream.listen((state) {
      print('masuk');
      if (state is FullServiceSuccess) {
        setState(() {
          if (widget.newTransactionFullService.package == null) {
            print('cold');
            default_price = int.parse(state.full_service[0].price.toString());
            full_service_name = state.full_service[0].type;
            default_price = default_price + widget.totalCost.toInt();
            totalPrice = default_price;
            payment_option = default_price;
          } else {
            print('cafe');
            // Pakage
            var data =
                widget.newTransactionFullService.package.toString().split('//');
            _bundle_cubit = BundleCubit()
              ..loadBundleProduct(int.parse(data[0]));
            _bundle_cubit.stream.listen((state) {
              if (state is BundleSuccess) {
                print('get bundle');
                print(state.bundle[0].bundle_price.toString());
                setState(() {
                  default_price =
                      int.parse(state.bundle[0].bundle_price.toString());
                  default_price = default_price + widget.totalCost.toInt();
                  totalPrice = default_price;
                  payment_option = default_price;
                });
              }
            });
            print('get bundle2');
            print(default_price);
            full_service_name = state.full_service[1].type;
          }
          setState(() {
            print('in init total price');
            print(totalPrice);
          });
        });
      }
    });
    // Point
    _userDataCubit = UserDataCubit()..loadUserData();
    _userDataCubit.stream.listen((state) {
      print('masuk');
      if (state is UserDataLoaded) {
        setState(() {
          point = int.parse(state.user.point);
        });
      }
    });

    // Data

    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDate(context),
                  const SizedBox(height: 20),
                  _buildOrderLocation(),
                  const SizedBox(height: 20),
                  _buildOrderDetails(),
                  const SizedBox(height: 20),
                  _buildDeliveryOption(),
                  const SizedBox(height: 20),
                  _buildDiscountOption(),
                  const SizedBox(height: 20),
                  _buildPaymentOptions(),
                  const SizedBox(height: 20),
                  _buildPaymentDetails(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          BlocProvider(
            create: (context) => _catering_bloc,
            child: BlocListener<CateringBloc, CateringBlocState>(
              listener: (context, state) {
                if (state is CateringBlocSuccess) {
                  AppExt.popScreen(context);
                  var responseM = state.message;
                  List<String> dataRes = responseM.split("//");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentPage(uuid: dataRes[1].toString()),
                      ));
                } else if (state is CateringBlocFailure) {
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    handlePlaceOrder();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Constants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0, 
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Place Order', 
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
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

  Widget _buildOrderLocation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Take your order at:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  base_delivery_name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  base_delivery_address,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
          const Divider(height: 32, color: Colors.grey),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'To your Address:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              var data_back = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreenCatering(
                          long: base_delivery_long,
                          lat: base_delivery_lat,
                        )),
              );
              if (data_back != null) {
                setState(() {
                  if (delivered.isNotEmpty) {
                    delivered.clear();
                  }
                  delivered.add(data_back);
                  delivery_place = delivered[0][1];
                  delivery_price = (int.parse(base_delivery_price) *
                          int.parse(delivered[0][0].toStringAsFixed(0)))
                      .toString();
                  totalPrice += int.parse(delivery_price);
                  payment_option += int.parse(delivery_price);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      delivery_place,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'assets/logos/logo_tikom_bulat_hijau_hitam.png', // Ganti dengan path gambar logo Anda
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Driver Tikom NIH',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'assets/logos/logo_tikom_bulat_hijau_hitam.png', // Ganti dengan path gambar logo Anda
                  width: 32,
                  height: 32,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${full_service_name}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.newTransactionFullService.add_on!['barista']?[1] !=
                          '0' &&
                      widget.newTransactionFullService.add_on!['service']?[1] !=
                          '') ...[
                    Text(
                      'Additional Extra:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  if (widget.newTransactionFullService.add_on!['barista']?[1] !=
                      '0') ...[
                    Text(
                      '${widget.newTransactionFullService.add_on!['barista']?[1]} x Barista - 4 Hours',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                  if (widget.newTransactionFullService.add_on!['service']?[1] !=
                      '0') ...[
                    Text(
                      '${widget.newTransactionFullService.add_on!['service']?[1]} x Service - 1 Hours',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                  if (widget.newTransactionFullService.custom_cup_name !=
                      '') ...[
                    Text(
                      'Custom Cup:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.newTransactionFullService.custom_cup_name,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                  if (widget.newTransactionFullService.custom_cup_notes !=
                      '') ...[
                    Text(
                      'Notes:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.newTransactionFullService.custom_cup_notes,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                default_price.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total :',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp $default_price',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountOption() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discount',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
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

                  double price_discountData = totalPrice * percentage;

                  double discounted_price = totalPrice - price_discountData;
                  int discounted_price2 = discounted_price.round();

                  disccount += price_discountData.round();
                  // print("Final Price: $finalPrice");
                  totalPrice -= disccount;
                  payment_option = totalPrice;
                });

                print(voucher);
              }
            },
            child: Row(
              children: [
                const Icon(Icons.card_giftcard, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'My Voucher',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
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
                    color: Colors.green,
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
                            totalPrice += disccount;
                            payment_option += disccount;
                            disccount = 0;
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
          const Divider(height: 32, color: Colors.grey),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'assets/logos/logo_tikom_bulat_hijau_hitam.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$point poin',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: usePoints,
                onChanged: (value) {
                  setState(() {
                    usePoints = value;
                    if (usePoints) {
                      disccount += point;
                      totalPrice -= point;
                      payment_option -= point;
                    } else {
                      disccount -= point;
                      totalPrice += point;
                      payment_option += point;
                    }
                  });

                  // Aksi ketika switch diubah
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Options',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Radio(
                value: PaymentOption.downPayment,
                groupValue: _selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentOption = value!;
                    payment_option = (totalPrice / 2).round();
                  });
                },
                activeColor: Colors.green,
              ),
              Text(
                'Down Payment (DP) - 50%',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: PaymentOption.fullPayment,
                groupValue: _selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentOption = value!;
                    payment_option = totalPrice;
                  });
                },
                activeColor: Colors.green,
              ),
              Text(
                'Full Payment',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Down Payment (DP) Amount : Rp $payment_option',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Sub Total',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text(
                'Rp $default_price',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text(
                '- Rp $disccount',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Price',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text(
                'Rp $delivery_price',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 32, color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payment',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${payment_option != totalPrice ? payment_option : totalPrice}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
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
                      ? 'Event now at ${DateFormat('MMM dd yyyy').format(selectedPickupDate)}'
                      : isSingleDate
                          ? 'Event on ${DateFormat('MMM dd yyyy').format(selectedDate)} at ${selectedTime.format(context)}'
                          : 'Event between ${DateFormat('MMM dd yyyy').format(selectedDateRange.start)} and ${DateFormat('MMM dd yyyy').format(selectedDateRange.end)} at ${selectedTime.format(context)}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPickupTimeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
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
                      'Set your delivery date and time',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Single Date'),
                        Switch(
                          value: !isSingleDate,
                          onChanged: (value) {
                            setState(() {
                              isSingleDate = !value;
                            });
                          },
                        ),
                        Text('Date Range'),
                      ],
                    ),
                    SizedBox(height: 16),
                    isSingleDate
                        ? ElevatedButton(
                            onPressed: () async {
                              await _selectDate(context);
                              setState(() {});
                            },
                            child: Text(
                              'Choose Date',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              DateTimeRange? picked = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                initialDateRange: selectedDateRange,
                              );
                              if (picked != null &&
                                  picked != selectedDateRange) {
                                setState(() {
                                  selectedDateRange = picked;
                                });
                              }
                            },
                            child: Text(
                              'Choose Date Range',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 16),
                    isSingleDate
                        ? Text(
                            DateFormat('EEEE, MMM d, yyyy')
                                .format(selectedDate),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                'From: ${DateFormat('EEE, MMM d, yyyy').format(selectedDateRange.start)}',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                'To: ${DateFormat('EEE, MMM d, yyyy').format(selectedDateRange.end)}',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
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
              ),
            );
          },
        );
      },
    );
  }
}

enum PaymentOption { downPayment, fullPayment }
