// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_cubit.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_state.dart';
import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/ui/screen/voucher/components/redeem.dart';
import 'package:tikom/ui/screen/voucher/components/voucher_card.dart';

import '../../../utils/constant.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  late MyVoucherCubit _MyVoucherDataCubit;

  @override
  void initState() {
    super.initState();
    _MyVoucherDataCubit = MyVoucherCubit()..loadMyVoucher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Voucher Saya',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // Help action
            },
          ),
        ],
      ),
      body: BlocBuilder<MyVoucherCubit, MyVoucherState>(
        bloc: _MyVoucherDataCubit,
        builder: (context, state) {
          if (state is MyVoucherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MyVoucherSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.voucher.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = state.voucher[index];
                  return VoucherCard(
                    title: data.name,
                    description: data.desc,
                    expiryDate: data.end_date,
                    discount: "${data.percentage}% OFF",
                    onclick: () {
                      Navigator.pop(context,
                          [data.uuid, data.name, '${data.percentage}']);
                    },
                  );
                },
              ),
            );
          }

          if (state is MyVoucherFailure) {
            print('error');
            print(state.message);
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RedeemVoucherPage()),
            );
          },
          child: Text(
            "Masukan Kode Voucher",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Constants.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
