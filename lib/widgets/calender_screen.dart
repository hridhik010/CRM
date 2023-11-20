import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CalendarScreen extends StatefulWidget {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String _month = DateFormat('MMMM').format(DateTime.now());
  Color primary = const Color(0xFFBBDEFB);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                "My Attendance",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth / 18,
                  fontFamily: "NexaBold",
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    _month,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth / 18,
                      fontFamily: "NexaBold",
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () async {
                      final month = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2099),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: primary,
                                secondary: primary,
                                onSecondary: Colors.white,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(primary: primary),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (month != null) {
                        setState(() {
                          _month = DateFormat('MMMM').format(month);
                        });
                      }
                    },
                    child: Text(
                      "Pick a Month",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 18,
                        fontFamily: "NexaBold",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 1.45,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        final documentData =
                            snap[index].data() as Map<String, dynamic>;

                        // Check if the 'date' field exists and is a Timestamp.
                        if (documentData.containsKey('date') &&
                            documentData['date'] is Timestamp) {
                          final date =
                              (documentData['date'] as Timestamp).toDate();
                          if (DateFormat('MMMM').format(date) == _month) {
                            return Container(
                              margin: EdgeInsets.only(
                                top: index > 0 ? 12 : 0,
                                left: 6,
                                right: 6,
                              ),
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat('EE \n dd').format(date),
                                          style: TextStyle(
                                            fontFamily: "NexaRegular",
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Check In",
                                          style: TextStyle(
                                            fontFamily: "NexaRegular",
                                            fontSize: 20,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          documentData['CheckIn'].toString(),
                                          style: const TextStyle(
                                            fontFamily: "NexaBold",
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Check Out",
                                          style: TextStyle(
                                            fontFamily: "NexaRegular",
                                            fontSize: 20,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                            documentData['Checkout'].toString(),
                                            style: const TextStyle(
                                              fontFamily: "NexaBold",
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
