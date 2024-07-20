import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tikom/data/blocs/event_data/event_data_bloc.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_cubit.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_state.dart';
import 'package:tikom/ui/screen/events/view_ticket.dart';

import '../../../utils/constant.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tickets',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<EventDataCubit, EventDataState>(
            bloc: EventDataCubit()..loadMyEventData(),
            builder: (context, state) {
              if (state is EventDataLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventDataSuccess) {
                if (state.eventData.isNotEmpty) {
                  return Column(
                    children: [
                      for (var i = 0; i < state.eventData.length; i++) ...[
                        TicketCard(
                          event: state.eventData[i].name,
                          location: state.eventData[i].location,
                          imageUrl: state.eventData[i].imgUrl,
                          status: 'Paid',
                          uuid: state.eventData[i].uuid,
                        ),
                      ]
                    ],
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
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String event;
  final String location;
  final String imageUrl;
  final String status;
  final String uuid;
  TicketCard({
    required this.event,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(imageUrl,
                    width: 80, height: 80, fit: BoxFit.cover),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              location,
                              style: GoogleFonts.poppins(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewTicketPage(uuid: uuid),
                      ),
                    );
                  },
                  style:ElevatedButton.styleFrom(
                    primary: Constants.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  child: Text(
                    'View Ticket',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
