import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employe.dart';

class EmployeeDetailsPage extends StatelessWidget {
  Color primary = const Color(0xFFBBDEFB);
  final Employee employee;
  final Uint8List? profileImage;

  EmployeeDetailsPage({required this.employee, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 80,
                  child: Image.network(
                      'https://tse2.mm.bing.net/th?id=OIP.OnvcA-1dBpBRlJo6_p-nxAHaHa&pid=Api&P=0&h=180')),
            ),
            SizedBox(height: 70),
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.name,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.email,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Position:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.position,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Department:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.department,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Phone Number :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.phonenumber,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Address:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              employee.address,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
