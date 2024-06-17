import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tikom/data/blocs/transaction/transaction_bloc.dart';

import 'history_detail.dart';

class RiwayatPemesananScreen extends StatefulWidget {
  @override
  State<RiwayatPemesananScreen> createState() => _RiwayatPemesananScreenState();
}

class _RiwayatPemesananScreenState extends State<RiwayatPemesananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Pemesanan',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        bloc: TransactionBloc()..data(),
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TransactionSuccessData) {
            if (state.transactions.length > 0) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  return buildOrderCard(context,
                      uuid: transaction.uuid,
                      status: transaction.status,
                      date: transaction.service_date,
                      totalItems: transaction.product_count,
                      totalPrice: transaction.price,
                      code: transaction.transaction_code);
                },
              );
            } else {
              return Center(
                child: Text(
                  'Data Kosong',
                  style: GoogleFonts.poppins(),
                ),
              );
            }
          }
          if (state is TransactionFailure) {
            print('error');
            print(state.error);
            return Center(
              child: Text(
                state.error,
                style: GoogleFonts.poppins(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildOrderCard(
    BuildContext context, {
    required String code,
    required String uuid,
    required String status,
    required String date,
    required int totalItems,
    required int totalPrice,
  }) {
    Color statusColor;
    switch (status) {
      case 'READY':
        statusColor = Colors.green;
        break;
      case 'PROCESSED':
      case 'PENDING':
      case 'WAITING PAYMENT':
        statusColor = Colors.orange;
        break;
      case 'CANCEL':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryOrderScreen(uuid: uuid),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey[300]!), // Border for the card
        ),
        elevation: 0, // Remove shadow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Code : $code',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      border: Border.all(color: statusColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(date)),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 8.0),
              Text(
                '$totalItems item • Rp $totalPrice',
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
