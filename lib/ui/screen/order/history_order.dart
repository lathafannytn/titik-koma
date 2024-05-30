// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/transaction/transaction_bloc.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 18, 74, 48),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
                Tab(text: 'Canceled'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildOrderList(context, 'PENDING'),
                  buildOrderList(context, 'COMPLATED'),
                  buildOrderList(context, 'CANCELED'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOrderList(BuildContext context, String status) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      bloc: TransactionBloc()..dataFilter(status),
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
                  return buildOrderItem(
                    context,
                    "Code : ${transaction.transaction_code}",
                    "Rp. ${transaction.price}",
                    transaction.status,
                    'assets/images/kopi_aren_doppio.jpg',
                    transaction.service_date
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('Data Kosong'));
          }
        }
        if (state is TransactionFailure) {
          print('error');
          print(state.error);
          return Center(child: Text(state.error));
        }
        return SizedBox();
      },
    );
  }

  Widget buildOrderItem(BuildContext context, String title, String subtitle,
      String status, String imagePath,String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(imagePath,
                width: 60, height: 60, fit: BoxFit.cover),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    // Icon(Icons.store, color: Colors.grey, size: 16),
                    // SizedBox(width: 4.0),
                    Text(subtitle,
                        style: GoogleFonts.poppins(color: Colors.grey)),
                  ],
                ),
                 Row(
                  children: [
                    Text(date,
                        style: GoogleFonts.poppins(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 18, 74, 48),
                    ),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 18, 74, 48),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
