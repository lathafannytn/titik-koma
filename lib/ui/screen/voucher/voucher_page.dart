// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_cubit.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_state.dart';
import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/ui/screen/voucher/redeem.dart';
import 'package:tikom/ui/screen/voucher/voucher_card.dart';

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
        title: Text(
          'Voucher Saya',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
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
                      Navigator.pop(context, [data.uuid,data.name,'${data.percentage}']);
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
        child: TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RedeemVoucherPage()),
            );
          },
          icon: Icon(Icons.card_giftcard, color: Colors.black),
          label: Text(
            "Masukan Kode Voucher",
            style: TextStyle(color: Colors.black),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ),
    );
  }
}
