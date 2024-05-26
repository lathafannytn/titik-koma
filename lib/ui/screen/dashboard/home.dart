import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/constant/color.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';
import 'package:tikom/data/models/user.dart';
import 'package:tikom/ui/screen/events/event.dart';
import 'package:tikom/ui/screen/poin/point_detail.dart';
import 'package:tikom/ui/screen/widget/popularwidget.dart';
import 'package:tikom/ui/screen/widget/reveralwidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDataCubit>(context).loadUserData();
    print('Home Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/background.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  BlocBuilder<UserDataCubit, UserDataState>(
                    builder: (context, state) {
                      if (state is UserDataLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is UserDataLoaded) {
                        return Column(
                          children: [
                            _buildUserInfo(context, state.user),
                            PopularWidget(),
                            Referral().show(context, state.user.referallCode),
                            PopularEventList(),
                          ],
                        );
                      } else if (state is UserDataError) {
                        return Center(child: Text(state.message));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, User user) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg")),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2))),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Hi, ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: user.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 25,
                  )),
            ],
          ),
        ),
        SizedBox(height: 60,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/logos/logo_tikom_bulat_hijau_hitam.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: '${user.point} '),
                                TextSpan(
                                  text: 'poin',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                          Icon(
                            Icons.discount,
                            color: Color.fromRGBO(68, 208, 145, 1.0),
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '10',
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tukarkan poinmu dengan rewards menarik",
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointDetailsScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
