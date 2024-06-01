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
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ListView.builder(
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
                ),
              );
            } else {
              return const Center(child: Text('Data Kosong'));
            }
          }
          if (state is TransactionFailure) {
            print('error');
            print(state.error);
            return Center(child: Text(state.error));
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryOrderScreen(uuid: uuid,),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    status,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(date))),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$totalItems item • Rp $totalPrice'),
                  ElevatedButton(
                    onPressed: () {
                      // Implementasikan fungsi pesan lagi
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                      elevation: 0, // Hilangkan bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Pesan Lagi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
