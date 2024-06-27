// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_cubit.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_state.dart';
import 'package:tikom/data/models/transaction_full_service.dart';

import 'menu_options_cafe.dart';

class PackageBundlingScreen extends StatefulWidget {
  final NewTransactionFullService newTransactionFullService;
  PackageBundlingScreen({required this.newTransactionFullService});

  @override
  _PackageBundlingScreenState createState() => _PackageBundlingScreenState();
}

class _PackageBundlingScreenState extends State<PackageBundlingScreen> {
  late BundleCubit _bundleCubit;

  @override
  void initState() {
    _bundleCubit = BundleCubit()..loadBundle();
    super.initState();
  }

  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/home.jpg',
    'assets/images/home2.jpg',
    'assets/images/home3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Add your back button functionality here
          },
        ),
        title: Text(
          'Package Bundling',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _images[index],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _images.map((url) {
              int index = _images.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: BlocBuilder<BundleCubit, BundleState>(
              bloc: _bundleCubit,
              builder: (context, state) {
                if (state is BundleLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BundleFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is BundleSuccess) {
                  print(state.bundle.length);
                  return ListView.builder(
                    itemCount: state.bundle.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      var bundleData = state.bundle[index];
                      return Center(
                        child: PackageItem(
                          title: bundleData.name,
                          price: 'IDR ${bundleData.bundle_price}',
                          pax: '${bundleData.desc}',
                          onTap: () {
                            // data
                            NewTransactionFullService newTransFullService =
                                NewTransactionFullService(
                                    full_service: widget
                                        .newTransactionFullService.full_service,
                                    package: '${bundleData.id}//${bundleData.max_buy}'
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuOptionCafe(newTransactionFullService: newTransFullService,),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    // children: [

                    //   Center(
                    //     child: PackageItem(
                    //       title: 'Package B',
                    //       price: 'IDR 6.000.000',
                    //       pax: '250 pax',
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => MenuOptionCafe(),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    //   Center(
                    //     child: PackageItem(
                    //       title: 'Package C',
                    //       price: 'IDR 7.000.000',
                    //       pax: '300 pax',
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => MenuOptionCafe(),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PackageItem extends StatelessWidget {
  final String title;
  final String price;
  final String pax;
  final VoidCallback onTap;

  PackageItem({
    required this.title,
    required this.price,
    required this.pax,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Image.asset(
                        'assets/logos/logo_tikom_bulat_hijau_hitam.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          price,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -25,
                        right: -30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: Color.fromARGB(255, 12, 190, 124),
                              width: 65,
                              height: 65,
                            ),
                            Text(
                              pax,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 12, 190, 124),
                    radius: 10,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
