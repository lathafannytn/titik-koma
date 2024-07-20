import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_my_point/fetch_my_point_cubit.dart';
import 'package:tikom/data/blocs/fetch_my_point/fetch_my_point_state.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';

import '../../../utils/constant.dart';

class PointDetailsScreen extends StatefulWidget {
  @override
  State<PointDetailsScreen> createState() => _PointDetailsScreenState();
}

class _PointDetailsScreenState extends State<PointDetailsScreen> {
  UserDataCubit? _userDataCubit;
  String myPoint = '';

  @override
  void initState() {
    _userDataCubit = BlocProvider.of<UserDataCubit>(context);
    _userDataCubit?.loadUserData();

    _userDataCubit?.stream.listen((state) {
      if (state is UserDataLoaded) {
        setState(() {
          myPoint = state.user.point;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Tikom Points',
          style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPointsSummary(),
              SizedBox(height: 16),
              SizedBox(height: 8),
              buildPointsHistory(),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Text(
            'Tikom Points History',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Here you can find the history of your Tikom Points transactions. Each entry shows the description, points, and the date of the transaction.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Close",
                style: GoogleFonts.poppins(
                  color: Constants.primaryColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildPointsSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Tikom Points',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                myPoint,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPointsHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Points History',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        GestureDetector(
          onTap: () {
            // View All action
          },
          child: Text(
            'View All',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color.fromARGB(255, 30, 83, 66), fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPointsHistory() {
    return BlocBuilder<PointHistoryCubit, PointHistoryState>(
      bloc: PointHistoryCubit()..loadPointHistory(),
      builder: (context, state) {
        if (state is PointHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PointHistorySuccess) {
          return Column(
            children: [
              for (var i = 0; i < state.voucher.length; i++)...[
                buildPointsHistoryItem(
                   state.voucher[i].desc, state.voucher[i].point,  state.voucher[i].created),
              ]
            ],
          );
        }

        if (state is PointHistoryFailure) {
          print('error');
          print(state.message);
          return Center(child: Text(state.message));
        }
        return SizedBox();
      },
    );
  }

  Widget buildPointsHistoryItem(String title, String points, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                date,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          Text(
            points,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
