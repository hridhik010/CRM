import 'package:flutter/material.dart';

import '../pages/homePage.dart';

class ReasonPage extends StatefulWidget {
  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  Color primary = Color(0xFFBBDEFB);

  Future _addEmployeeToFirebase() async {
    // Optionally, show a success message or navigate to a different screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Apply Your Leave Here",
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 30,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: TextField(
                    decoration: InputDecoration(border: InputBorder.none)),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: InkWell(
                  onTap: () async {
                    await _addEmployeeToFirebase();
                    AlertDialog alert = AlertDialog(
                      title: Text("Successfully Applied"),
                      content: Text(
                          "Your leave will be approved throgh email after the admin will seend it"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            Docu_Name: '',
                                          )));
                            },
                            child: Text("OK")),
                      ],
                    );
                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(4),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: primary),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
