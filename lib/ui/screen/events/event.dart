// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_cubit.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_state.dart';

import 'event_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopularEventList(),
    );
  }
}

class PopularEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Event Collaboration TIKOM',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  print('See All diklik');
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color.fromARGB(255, 45, 136, 93),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          BlocBuilder<EventDataCubit, EventDataState>(
            bloc: EventDataCubit()..loadEventDataLimit(),
            builder: (context, state) {
              if (state is EventDataLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventDataSuccess) {
                if (state.eventData.isNotEmpty) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: state.eventData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var data = state.eventData[index];
                        return PopularEventCard(context, data);
                      },
                    ),
                  );
                } else {
                  return Text('Belum Ada Event');
                }
              } else if (state is EventDataFailure) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget PopularEventCard(BuildContext context, dynamic data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                    uuid: data.uuid,
                  )),
        );
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    'assets/images/home.jpg',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // child: Text(
                    //   'Dance',
                    //   style: GoogleFonts.poppins(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              // child: Row(
              //   children: [
              //     Text(
              //       'Altanito Salami',
              //       style: GoogleFonts.poppins(),
              //     ),
              //   ],
              // ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                data.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                '${data.start_date} - ${data.end_date}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://www.example.com/participant1.jpg',
                        ),
                        radius: 12,
                      ),
                      Positioned(
                        left: 15,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://www.example.com/participant2.jpg',
                          ),
                          radius: 12,
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            '+15',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12),
                          ),
                          radius: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    '\FREE',
                    style: GoogleFonts.poppins(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
