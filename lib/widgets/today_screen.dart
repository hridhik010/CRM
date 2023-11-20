import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/drawer/drawer_page.dart';
import 'package:employee_app/pages/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:slide_action/slide_action.dart';

import 'check_in_check_out.dart';

class TodayScreen extends StatefulWidget {
  String document_name;
  TodayScreen({Key? key, required this.document_name}) : super(key: key);
  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String employeeId = AppConstant.id.toString();
  late String document_name;

  double screenHeight = 0;
  double screenWidth = 0;
  bool ischeck = false;
  Color primary = Color(0xFFBBDEFB);
  String locationData = "  ";
  String? time = '--/--';
  String checkIn = '--/--';
  String checkout = '--/--';

  Future<void> getLocationAndPlacemark() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //nothing
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String? address = placemark.street;
        String? city = placemark.locality;
        String? state = placemark.administrativeArea;
        String? country = placemark.country;
        String? postalCode = placemark.postalCode;
        setState(() {
          locationData =
              'Address: $address, $city, $state, $country, $postalCode';
        });
        print('Address: $address, $city, $state, $country, $postalCode');
      } else {
        print('No placemark found');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Today's Status"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                "welcome",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth / 20,
                    fontFamily: "NexaRegular"),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'HRIDHIK',
                style: TextStyle(
                    fontSize: screenWidth / 18, fontFamily: "NexaBold"),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                "Today's Status",
                style: TextStyle(
                    fontSize: screenWidth / 18, fontFamily: "NexaBold"),
              ),
            ),
            Check_in_Out_widget(
              check_in_out: '${checkout}',
              check_in_time: '${time}',
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(
                          color: primary,
                          fontSize: screenWidth / 18,
                          fontFamily: "NexaBold"),
                      children: [
                        TextSpan(
                            text:
                                DateFormat(' MMMM yyyy').format(DateTime.now()),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "NexaBold",
                                fontSize: screenWidth / 20))
                      ]),
                )),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontFamily: "nexaRegular",
                          color: Colors.black54),
                    ),
                  );
                }),
            time == '--/--'
                ? Container(
                    margin: const EdgeInsets.only(top: 35),
                    //slideAction for CheckIns
                    child: SlideAction(trackBuilder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            // Show loading if async operation is being performed
                            state.isPerformingAction
                                ? "Check In..."
                                : "Slide to Check In",
                          ),
                        ),
                      );
                    }, thumbBuilder: (context, state) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBDEFB),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          // Show loading indicator if async operation is being performed
                          child: state.isPerformingAction
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                        ),
                      );
                    },

                        //action for check_in
                        action: () async {
                      // to get checked_in location
                      getLocationAndPlacemark();
                      print(locationData);

                      var checkin =
                          "${DateFormat('hh:mm').format(DateTime.now())} ";

                      time = checkin;

                      // Async operation
                      await Future.delayed(
                        const Duration(seconds: 1),
                        () => debugPrint(
                            DateFormat('hh:mm').format(DateTime.now())),
                      );
                      try {
                        await FirebaseFirestore.instance
                            .collection('employees')
                            .doc(employeeId)
                            .update({
                          'CheckIn': checkin,
                          'Checkout': '--/--',
                          'location': locationData,
                          'date': Timestamp.now(),
                        });
                      } catch (e) {
                        print('Error updating Firestore: $e');
                      }
                      setState(() {
                        ischeck = true;
                      });
                      getLocationAndPlacemark();
                    }),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 35),
                    //SlideAction for check out
                    child: SlideAction(
                      trackBuilder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              // Show loading if async operation is being performed
                              state.isPerformingAction
                                  ? "Check Out..."
                                  : "Slide to Check Out",
                            ),
                          ),
                        );
                      },
                      thumbBuilder: (context, state) {
                        return Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: primary, // Change the color as needed
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: state.isPerformingAction
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      },
                      action: () async {
                        getLocationAndPlacemark();
                        var checkouts =
                            "${DateFormat('hh:mm').format(DateTime.now())} ";
                        print("checkout");
                        checkout = checkouts;
                        setState(() {
                          ischeck = false; // Change this to false
                        });
                        // Async operation
                        await Future.delayed(
                          const Duration(seconds: 1),
                          () => debugPrint(
                              DateFormat('hh:mm').format(DateTime.now())),
                        );
                        await FirebaseFirestore.instance
                            .collection('employees')
                            .doc()
                            .update({
                          'Checkout': checkout,
                          'date': Timestamp.now(),
                          'location': locationData,
                        });
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
