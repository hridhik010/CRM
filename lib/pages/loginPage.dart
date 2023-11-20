import 'package:employee_app/widgets/today_screen.dart';
import 'package:flutter/material.dart';

import 'employee_register.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;
  Color primary = Color(0xFFBBDEFB);
  bool isLoading = false;
  String errorMessage = "";

  void PassId() {
    String myData = idController.text.trim();
    TodayScreen todayScreen = TodayScreen(document_name: myData);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildLoginForm(),
            if (isLoading) CircularProgressIndicator(), // Loading indicator
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: screenHeight / 3,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.lightBlue],
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(130)),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          width: isLoading ? 50 : screenWidth / 5,
          height: isLoading ? 50 : screenWidth / 5,
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Icon(
                  Icons.person,
                  size: screenWidth / 5,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.only(
        top: screenHeight / 17,
        bottom: screenHeight / 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 12),
      child: Column(
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: screenWidth / 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          _fieldTitle("Employee ID"),
          SizedBox(height: 15),
          _formField(
            "Enter your ID",
            Icons.person,
            idController,
            false,
          ),
          SizedBox(height: 15),
          _fieldTitle("Password"),
          SizedBox(height: 15),
          _formField(
            "Enter your Password",
            Icons.lock,
            pwController,
            true,
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    _handleLogin();
                    PassId();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: isLoading
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeRegister()),
              );
            },
      child: Text(
        "Register?",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 1));

    String id = idController.text.trim();
    String password = pwController.text.trim();

    if (id.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Please enter both ID and Password";
        isLoading = false;
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                Docu_Name: idController.text,
              )),
    );
  }

  Widget _fieldTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _formField(
    String hintText,
    IconData icon,
    TextEditingController controller,
    bool obscure,
  ) {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
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
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              enableSuggestions: false,
              autocorrect: false,
              controller: controller,
              obscureText: obscure,
              cursorColor: primary, // Customize cursor color
              style: TextStyle(
                color: Colors.black, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
