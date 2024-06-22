// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tikom/data/blocs/event_data/event_data_bloc.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_cubit.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_state.dart';
import 'package:tikom/ui/screen/dashboard/home.dart';
import 'package:tikom/ui/screen/events/view_ticket.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/ui/widgets/loading_dialog.dart';

class EventDetailsPage extends StatefulWidget {
  final String uuid;

  const EventDetailsPage({required this.uuid});
  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late EventDataBloc _eventDataBloc;

  @override
  void initState() {
    super.initState();
    _eventDataBloc = EventDataBloc();
  }

  void handleBuyTicket() {
    try {
      AppExt.hideKeyboard(context);
      // LoadingDialog.show(context, barrierColor: Color(0xFF777C7E));
      _eventDataBloc.add(EventDataBlocButtonPressed(event: widget.uuid));
    } catch (e) {
      print('Error occurred: ${e.toString()}');
      DialogTemp().Informasi(
          context: context,
          onYes: () {
            Navigator.pop(context);
          },
          onYesText: 'Yes',
          title: 'Error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => EventDataCubit()..loadEventDetailData(widget.uuid),
        child: BlocBuilder<EventDataCubit, EventDataState>(
          builder: (context, state) {
            if (state is EventDataLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is EventDataSuccessDetail) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Section with Image
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            'assets/images/home.jpg',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.eventData.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.grey),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              state.eventData.location,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            state.eventData.start_date,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            state.eventData.desc,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Max Person',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${state.eventData.max_person}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Location',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(state.eventData.lat),
                                    double.parse(state.eventData
                                        .long)), // Replace with correct coordinates
                                zoom: 14.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId('eventLocation'),
                                  position: LatLng(
                                      double.parse(state.eventData.lat),
                                      double.parse(state.eventData.long)),
                                ),
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          BlocListener<EventDataBloc, EventDataBlocState>(
                            bloc: _eventDataBloc,
                            listener: (context, state) {
                              if (state is EventDataBlocSuccess) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 60,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Congratulations!',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'You have successfully placed an order for the event. Enjoy the event!',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewTicketPage(
                                                            uuid: widget.uuid)),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.pink,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                            ),
                                            child: Text(
                                              'View E-Ticket',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()),
                                              );
                                            },
                                            child: Text(
                                              'Go to Home',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (state is EventDataBlocFailure) {
                                DialogTemp().Informasi(
                                    context: context,
                                    onYes: () {
                                      Navigator.pop(context);
                                    },
                                    onYesText: 'Ya',
                                    title: state.message);
                              }
                            },
                            child: Center(
                              child: ElevatedButton(
                                onPressed: handleBuyTicket,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.pink,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Book Ticket',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is EventDataFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
