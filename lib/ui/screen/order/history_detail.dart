// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/transaction/transaction_bloc.dart';

class DetailHistoryOrderScreen extends StatefulWidget {
  // final String status;
  // final String date;
  // final String time;
  // final String location;
  // final List<String> items;
  // final int totalItems;
  // final int totalPrice;
  // final String orderId;
  // final String orderTime;
  // final String orderChannel;
  // final String paymentMethod;
  // final int voucher;
  // final int points;
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
        title: Text('Detail Transaction'),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline_outlined, color: Colors.green),
                          SizedBox(width: 8.0),
                          Text(
                            state.transactions[0].status,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Card(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   location,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // Text(
                          //   'Detail Location'

                          // ),
                          SizedBox(height: 12.0),
                          Text('Product'),
                          SizedBox(height: 3.0),
                          for( var i = 0; i < state.transactions[0].product_detail.length; i++ )...[
                            Text("${i+1}. ${state.transactions[0].product_detail[i].name}"),
                          ],
                          // ...items.map((item) => Text(item)).toList(),
                          Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal'),
                              Text('Rp ${state.transactions[0].price}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Voucher'),
                              Text('- Rp ${state.transactions[0].price_discount}', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp ${state.transactions[0].price_amount}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              // Text('TIKOM Points'),
                              Text('Waktu Pemesanan'),
                              // Text('Saluran Pesanan'),
                              Text('Metode Pembayaran'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text('+$points pts'),
                              Text('${state.transactions[0].service_date}'),
                              // Text(orderChannel),
                              Text('${state.transactions[0].payment_type}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                
                ],
              );
            }
            if (state is TransactionFailure) {
              print('error');
              print(state.error);
              return Center(child: Text(state.error));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
