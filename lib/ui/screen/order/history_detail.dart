// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tikom/data/blocs/transaction/transaction_bloc.dart';
import 'package:tikom/ui/screen/order/payment_qris.dart';

class DetailHistoryOrderScreen extends StatefulWidget {
  final String uuid;

  const DetailHistoryOrderScreen({required this.uuid});

  @override
  State<DetailHistoryOrderScreen> createState() =>
      _DetailHistoryOrderScreenState();
}

class _DetailHistoryOrderScreenState extends State<DetailHistoryOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaction',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          bloc: TransactionBloc()..dataDetail(widget.uuid),
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TransactionSuccessData) {
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.transactions[0].transaction_code,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            state.transactions[0].status == 'WAITING PAYMENT' 
                                ? Icons.error_outline
                                : Icons.check_circle_outline_outlined,
                            color: state.transactions[0].status ==
                                    'WAITING PAYMENT'
                                ? Colors.red
                                : Colors.green,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            state.transactions[0].status,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Card(
                    margin: EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 3.0),
                          for (var i = 0;
                              i < state.transactions[0].product_detail.length;
                              i++) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${i + 1}. ${state.transactions[0].product_detail[i].name} (${state.transactions[0].product_detail[i].pivot_quantity})",
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                                Text(
                                    'Rp ${state.transactions[0].product_detail[i].pivot_price}',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ],
                          Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Rp ${state.transactions[0].price}',
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Voucher',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(
                                '- Rp ${state.transactions[0].price_discount}',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.red),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Rp ${state.transactions[0].price_amount}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('TIKOM Points',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Waktu Pemesanan',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Saluran Pesanan',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('+${state.transactions[0].point}',
                                  style: GoogleFonts.poppins(fontSize: 13)),
                              Text(
                                DateFormat('dd MMM yyyy HH:mm').format(
                                    DateTime.parse(
                                        state.transactions[0].service_date)),
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              Text(state.transactions[0].base_delivery.name,
                                  style: GoogleFonts.poppins(fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state.transactions[0].is_fullservice == 1) ...[
                    Card(
                      margin: EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Catering',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text('Barista',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text('Service',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text('Custom Cup',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${state.transactions[0].catering_name}',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                Text('+${state.transactions[0].barista_count}',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                Text('+${state.transactions[0].service_count}',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                Text('${state.transactions[0].custom_cup}',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Inventory Item',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            SizedBox(height: 3.0),
                            for (var i = 0;
                                i < state.transactions[0].inventoryItems!.length;
                                i++) ...[
                              Text(
                                "${i + 1}. ${state.transactions[0].inventoryItems?[i].name}",
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (state.transactions[0].media != null) ...[
                    for (var i = 0;
                        i < state.transactions[0].media!.length;
                        i++) ...[
                      Card(
                        margin: EdgeInsets.only(bottom: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.transactions[0].media![i].description,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              const SizedBox(height: 10),
                              Image.network(
                                state.transactions[0].media![i].url,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                  if (state.transactions[0].status == 'WAITING PAYMENT') ...[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(uuid: state.transactions[0].uuid),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Payment',
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              );
            }
            if (state is TransactionFailure) {
              print('error');
              print(state.error);
              return Center(
                child:
                    Text(state.error, style: GoogleFonts.poppins(fontSize: 14)),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
