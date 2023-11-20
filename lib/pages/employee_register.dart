import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/pages/loginPage.dart';
import 'package:employee_app/pages/app_constant.dart';
import 'package:flutter/material.dart';

class EmployeeRegister extends StatefulWidget {
  const EmployeeRegister({Key? key}) : super(key: key);

  @override
  State<EmployeeRegister> createState() => _EmployeeRegisterState();
}

class _EmployeeRegisterState extends State<EmployeeRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;
  Color primary = Color(0xFFBBDEFB);
  int? random4DigitNumber;

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(9000) +
        1000; // Generates a number between 1000 and 9999
  }

  Future _addEmployeeToFirebase() async {
    String name = nameController.text;
    String email = emailController.text;
    String department = departmentController.text;

    if (name.isNotEmpty && email.isNotEmpty) {
      CollectionReference employees =
          FirebaseFirestore.instance.collection('employees');

      try {
        random4DigitNumber = generateRandomNumber();
        AppConstant.id = random4DigitNumber;

        print(random4DigitNumber);
        // Add a new document with a custom ID
        await employees.doc(random4DigitNumber.toString()).set({
          'id': random4DigitNumber.toString(),
          'name': name,
          'email': email,
          'department': department,
        });

        print('Employee details added successfully');
      } catch (e) {
        print('Error adding employee details: $e');
      }

      nameController.clear();
      emailController.clear();
      departmentController.clear();
      // Optionally, show a success message or navigate to a different screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
            ),
            child: Hero(
              tag: 'registrationIcon',
              child: Icon(
                Icons.person,
                size: screenWidth / 5,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 17, bottom: screenHeight / 20),
            child: Column(children: [
              Text(
                'Register',
                style: TextStyle(
                  fontSize: screenWidth / 18,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              fieldTitle("Employee Name"),
              SizedBox(
                height: 15,
              ),
              formField("Enter your Name", Icons.person, nameController, false,
                  TextInputType.text),
              SizedBox(
                height: 15,
              ),
              fieldTitle("Email"),
              SizedBox(
                height: 15,
              ),
              formField("Enter your Email Address", Icons.mail, emailController,
                  false, TextInputType.text),
              SizedBox(
                height: 25,
              ),
              fieldTitle("Department"),
              formField("Enter your Department", Icons.local_fire_department,
                  departmentController, false, TextInputType.text),
            ]),
          ),
          GestureDetector(
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      await _addEmployeeToFirebase();
                      AlertDialog alert = AlertDialog(
                        title: Text("Successfully Registered"),
                        content:
                            Text("Password & ID will be given by the Admin"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        },
                      );
                    } else {
                      // Handle the case when the fields are not filled
                      AlertDialog alert = AlertDialog(
                        title: Text("Error"),
                        content: Text("Please fill in all fields"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the alert dialog
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        },
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: screenWidth,
                    height: 50,
                    margin: EdgeInsets.only(top: screenHeight / 80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty)
                          ? Colors.blue
                          : Colors
                              .grey, // Change button color based on condition
                    ),
                    child: Center(
                      child: Text(
                        (nameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty)
                            ? "Register"
                            : "Please fill in all fields", // Conditionally change text
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
      child: Container(
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget formField(
      String hintText,
      IconData icon,
      TextEditingController controller,
      bool obscureText,
      TextInputType keyboard) {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 6,
            child: Icon(
              icon,
              color: primary,
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: screenHeight / 50),
                border: InputBorder.none,
                hintText: hintText,
              ),
              enableSuggestions: false,
              autocorrect: false,
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboard,
            ),
          ),
        ],
      ),
    );
  }
}
