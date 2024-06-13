import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_cubit.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_state.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/ui/screen/catering/customizable_cup.dart';

class AdditionalExtrasScreen extends StatefulWidget {
  const AdditionalExtrasScreen({required this.newTransactionFullService});
  final NewTransactionFullService newTransactionFullService;
  @override
  _AdditionalExtrasScreenState createState() => _AdditionalExtrasScreenState();
}

class _AdditionalExtrasScreenState extends State<AdditionalExtrasScreen> {
  String baristaUUID = '';
  int baristaCount = 0;
  int baristaPrice = 0;

  String serviceUUID = '';
  int serviceCount = 0;
  int servicePrice = 0;

  late AddOnCateringDataCubit _addOnCateringDataCubit;

  double get totalCost {
    return (baristaCount * baristaPrice.toDouble()) +
        (serviceCount * servicePrice.toDouble());
  }

  @override
  void initState() {
    _addOnCateringDataCubit = AddOnCateringDataCubit()..loadAddOnCatering();
    _addOnCateringDataCubit.stream.listen((state) {
      if (state is AddOnCateringDataSuccess) {
        setState(() {
          baristaUUID = state.data[0].uuid;
          baristaPrice = state.data[0].extraPrice;

          serviceUUID = state.data[1].uuid;
          servicePrice = state.data[1].extraPrice;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Additional Extras ',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCounterRow(
              'Barista',
              'Rp $baristaPrice / 6 hours',
              baristaCount,
              () => setState(() => baristaCount++),
              () => setState(() => baristaCount > 0 ? baristaCount-- : 0),
            ),
            _buildCounterRow(
              'Service',
              'Rp $servicePrice / hour',
              serviceCount,
              () => setState(() => serviceCount++),
              () => setState(() => serviceCount > 0 ? serviceCount-- : 0),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Map<String, List<String>> addOn = {
                    'barista': [baristaUUID.toString(),baristaCount.toString()],
                    'service': [serviceUUID.toString(),serviceCount.toString()],
                  };

                  NewTransactionFullService newTransFullService =
                      NewTransactionFullService(
                    full_service: widget.newTransactionFullService.full_service,
                    product: widget.newTransactionFullService.product,
                    add_on: addOn,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomizableCupScreen(totalCost: totalCost, newTransactionFullService:newTransFullService)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Add - Rp ${totalCost.toStringAsFixed(0)}',
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
      ),
    );
  }

  Widget _buildCounterRow(
    String title,
    String price,
    int count,
    VoidCallback onIncrement,
    VoidCallback onDecrement,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '  (+ $price)',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: onDecrement,
              ),
              Text(
                '$count',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
