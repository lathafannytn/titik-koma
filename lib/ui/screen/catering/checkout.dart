import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/data/repository/transaction_repository.dart';
import 'package:tikom/ui/screen/catering/map.dart';

class CheckoutServiceScreen extends StatefulWidget {
  final NewTransactionFullService newTransactionFullService;
  CheckoutServiceScreen({required this.newTransactionFullService});
  @override
  State<CheckoutServiceScreen> createState() => _CheckoutServiceScreenState();
}

class _CheckoutServiceScreenState extends State<CheckoutServiceScreen> {
  String delivery_place = 'Pilih Alamat';
  String delivery_price = '';

  int base_delivery_id = 0;
  String base_delivery_name = '';
  String base_delivery_address = '';
  String base_delivery_price = '';
  String base_delivery_long = '';
  String base_delivery_lat = '';

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

  @override
  void initState() {
    super.initState();
    handleBaseDelivery();
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol Place Order ditekan
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
        ],
      ),
    );
  }

  Widget _buildOrderLocation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
                  'Take your order at :',
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
          // MapScreenCatering
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
                setState(() {});
              }
              // print(delivered);/
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Text(
                    delivery_place,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
                  fontSize: 16, // Ukuran lebih besar
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton.icon(
              //   onPressed: () {
              //     // Aksi ketika tombol add more ditekan
              //   },
              //   icon: const Icon(Icons.add, color: Colors.green),
              //   label: Text(
              //     'add more',
              //     style: GoogleFonts.poppins(
              //       fontSize: 14,
              //       color: Colors.green,
              //     ),
              //   ),
              // ),
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
                    'Pop-Up Cafe - 250 pax',
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
                      '${widget.newTransactionFullService.add_on!['barista']?[1]} x Barista - 6 Hours',
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
                'Rp 6.250.000',
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
                'Rp 6.250.000',
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
          Row(
            children: [
              const Icon(Icons.card_giftcard, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'my voucher',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          const Divider(height: 32, color: Colors.grey),
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
              Expanded(
                child: Text(
                  '10000 poin',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: true,
                onChanged: (value) {
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
                value: 0,
                groupValue: 0, // Sesuaikan dengan nilai grup yang dipilih
                onChanged: (value) {
                  // Aksi ketika opsi pembayaran dipilih
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
                value: 1,
                groupValue: 0, // Sesuaikan dengan nilai grup yang dipilih
                onChanged: (value) {
                  // Aksi ketika opsi pembayaran dipilih
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
            'Down Payment (DP) Amount : Rp 3.125.000',
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
                'Rp 3.125.000',
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
                '- Rp 10.000',
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
                'Rp 200.000',
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
                'Rp 3.315.000',
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
}
