import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_cubit.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_state.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_cubit.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_state.dart';
import 'package:tikom/data/models/transaction_full_service.dart';

import 'package:tikom/ui/screen/catering/menu_option.dart';

class PackageScreen extends StatefulWidget {
  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TIKOM Coffee Catering',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<FullServiceCubit, FullServiceState>(
          bloc: FullServiceCubit()..loadFullService(),
          builder: (context, state) {
            if (state is FullServiceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FullServiceSuccess) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Choose Service',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 300,
                              child: PageView(
                                children: [
                                  PackageCard(
                                    title:state.full_service[0].type,
                                    price: 'only IDR ${state.full_service[0].price}',
                                    description:
                                        state.full_service[0].description,
                                    includes: const [
                                      'serve 120 pax 8 oz cups (mini) OR serve 80 pax 12 oz cups (regular)',
                                      '6 hours rental of 1 unit Ice Cold Dispenser',
                                      'Ice Cubes + Styrofoam Box',
                                      'Napkins, Straws',
                                    ],
                                    onTap: () {
                                      print('Pop-Up Cold Card Clicked');
                                      NewTransactionFullService newTransFullService = NewTransactionFullService(
                                        full_service: state.full_service[0].id
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MenuOptionsScreen(newTransactionFullService: newTransFullService)));
                                    },
                                  ),
                                  PackageCard(
                                    title: 'Pop-Up Cafe',
                                    price: 'start from IDR 5.000.000',
                                    description:
                                        'hot & cold beverages only, with barista',
                                    includes: const [
                                      'serve 100 pax 8 oz cups (mini) OR serve 70 pax 12 oz cups (regular)',
                                      '6 hours rental of 1 unit Hot Dispenser',
                                      'Hot Water + Cups',
                                      'Napkins, Stirrers',
                                    ],
                                    pax: '200\npax',
                                    onTap: () {
                                      // Action saat card diklik
                                      print('Pop-Up Cafe Card Clicked');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            if (state is FullServiceFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List<String> includes;
  final String? pax;
  final VoidCallback? onTap;

  PackageCard({
    required this.title,
    required this.price,
    required this.description,
    required this.includes,
    this.pax,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
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
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
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
                    if (pax != null)
                      Positioned(
                        top: -25,
                        right: -30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: Colors.green,
                              width: 65,
                              height: 65,
                            ),
                            Text(
                              pax!,
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
              const SizedBox(height: 15),
              Center(
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              Text(
                "what's include :",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: includes
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(Icons.check,
                                    color: Colors.green[700], size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'technical requirements',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.green[700],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.green[700],
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'technical requirements',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Electrical :',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '• 4400w electricity\n• 1x 20A cable',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Space :',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '• Minimum 1.2m x 2m\n• Recommended 2m x 2m',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Table :',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '• Minimum of 2x 120cm Tables: 1 for the bar and 1 for general use.\n• Recommended: 3 tables.\n• For 1pc bar table, must be able to support a total weight of 100kg.',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('OK'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "what's exclude",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.green[700],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.green[700],
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "what's exclude",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '• Transport\n• Barista',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('OK'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
