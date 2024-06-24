// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tikom/data/blocs/user_data/user_data_cubit.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';
import 'package:tikom/ui/screen/events/myticket.dart';
import 'package:tikom/ui/screen/kode_referal/kode_referal.dart';
import 'package:tikom/ui/screen/login/otp.dart';
import 'package:tikom/ui/screen/login/signin.dart';
import 'package:tikom/ui/screen/order/checkout.dart';
import 'package:tikom/ui/screen/profile/components/edit.dart';
import 'package:tikom/ui/screen/profile/components/profile_about.dart';
import 'package:tikom/ui/screen/voucher/voucher_page.dart';
import 'package:tikom/ui/screen/profile/components/profile_menu.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/utils/storage_service.dart';

import '../order/add_on.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDataCubit? _userDataCubit;

  @override
  void initState() {
    super.initState();
    _userDataCubit = BlocProvider.of<UserDataCubit>(context);
    _userDataCubit
        ?.loadUserData();
    print('Profile Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is UserDataLoaded) {
                final user = state.user;
                print('User countVoucher: ${user.countVoucher}');
                return buildProfileContent(
                    context,
                    user.name,
                    user.point.toString(),
                    user.referallCode,
                    user.countVoucher.toString());
              } else if (state is UserDataError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Center(child: Text('Unexpected state'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProfileContent(BuildContext context, String userName,
      String userPoints, String referral_code, String userVoucher) {
    return Column(
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
            Column(
              children: [
                SizedBox(
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg",
                                ),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                          ),
                          SizedBox(
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
                                  text: userName,
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
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildIconColumn(context,
                              label: 'TIKOM Poin',
                              iconPath: 'assets/icons/logo_poin.svg',
                              value: userPoints,
                              onTap: () {}),
                          verticalDivider(),
                          buildIconColumn(
                            context,
                            label: 'Vouchers',
                            iconPath: 'assets/icons/discount.svg',
                            value: userVoucher,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoucherPage())),
                          ),
                          verticalDivider(),
                          buildIconColumn(context,
                              label: 'Kode Referral',
                              iconPath: 'assets/icons/qr.svg',
                              value: '',
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KodeReferralPage(
                                          code: referral_code)))),
                        ],
                      ),
                    ),
                  ),
                ),
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/user.svg",
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage())),
                ),
                ProfileMenu(
                  text: "My Ticket",
                  icon: "assets/icons/user.svg",
                  press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TicketsScreen())),
                ),
                ProfileMenu(
                  text: "Terms & Conditions",
                  icon: "assets/icons/setting.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/help_care.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "About",
                  icon: "assets/icons/about.svg",
                  press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileAbout())),
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/logout.svg",
                  press: () {
                    DialogTemp().Konfirmasi(
                      context: context,
                      onYes: () {
                        StorageService.removeData('token');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      title: "Apakah Ingin Keluar Aplikasi?",
                      onYesText: 'Ya',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIconColumn(BuildContext context,
      {required String label,
      required String iconPath,
      required String value,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath,
                    width: 20,
                    height: 20,
                    color: Color.fromRGBO(68, 208, 145, 1.0)),
                SizedBox(width: 4),
                Text(value,
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalDivider() => Container(
      color: Colors.grey[300],
      width: 1,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10));
}
