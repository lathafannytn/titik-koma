// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:tikom/screen/widget/appwidget.dart';
// import 'package:tikom/screen/widget/callcenterwidget.dart';
// import 'package:tikom/screen/widget/popularwidget.dart';
// import 'package:tikom/screen/widget/promowidget.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           AppWidget(),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: 10.0,
//               horizontal: 15.0,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 50.0,
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF3F3F3),
//                       borderRadius: BorderRadius.circular(10.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2.0,
//                           blurRadius: 5.0,
//                           offset: Offset(0, 1.0),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: "What would you like to have?",
//                           border: InputBorder.none,
//                           prefixIcon: Icon(
//                             CupertinoIcons.search,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                     width:
//                         10), // Spacer untuk memberikan jarak antara TextFormField dan InkWell
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(68, 208, 145, 1.0),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Icon(
//                       Icons.filter_list,
//                       color: Colors.black,
//                       size: 28.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 20.0,
//               left: 10.0,
//             ),
//             child: Text(
//               "Lets find your best favorite service!",
//               style: TextStyle(
//                 fontWeight: FontWeight.w900,
//                 fontSize: 30.0,
//               ),
//             ),
//           ),
//           PromoWidget(),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 20.0,
//               left: 10.0,
//               right: 10.0,
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Popular",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onTap: () {
//                     // Tambahkan aksi yang diinginkan saat teks diklik
//                   },
//                   child: Text(
//                     "see all",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13.0,
//                       color: Colors.orange,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 10.0,
//               right: 10.0,
//             ),
//             child: Text(
//               "See the most popular service on order",
//               style: TextStyle(
//                 fontSize: 10.0,
//               ),
//             ),
//           ),
//           PopularWidget(),
//           CallCenterWidget(),
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/home.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.0,
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
                                            "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg")),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context)
                                    .style, // inherits default style
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Hi, ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors
                                          .white, // set text color to white
                                      fontSize: 24, // set a larger font size
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Fanny',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .white, // set text color to white
                                      fontSize: 24, // set a larger font size
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
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15),
                  //   child: Container(
                  //     height: 60,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFFF5F5F7),
                  //         borderRadius: BorderRadius.circular(30)),
                  //     child: TextField(
                  //       cursorHeight: 20,
                  //       autofocus: false,
                  //       decoration: InputDecoration(
                  //           hintText: "Cari Toko Kofi Favoritmu",
                  //           prefixIcon: Icon(Icons.search),
                  //           border: OutlineInputBorder(
                  //               borderSide:
                  //                   BorderSide(color: Colors.grey, width: 2),
                  //               borderRadius: BorderRadius.circular(30))),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
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
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '100 ',
                                      ),
                                      TextSpan(
                                        text: 'poin',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30),
                                Icon(
                                  Icons.discount,
                                  color: Color.fromRGBO(68, 208, 145, 1.0),
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '8',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),

                                //Divider(),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // BUAT ISI KEMANA NYA CIE
                                print('Icon tapped!');
                              },
                              child: Icon(Icons.arrow_forward_ios, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[40],
                    borderRadius: BorderRadius.circular(30)),
              )
            ],
          )
        ],
      )),
    );
  }
}
