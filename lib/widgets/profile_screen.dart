import 'dart:typed_data';

import 'package:employee_app/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'EmployeeDetailsPage.dart';
import 'employe.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

late final String title;
Uint8List? _image;

void selectImage() async {
  Uint8List img = await pickImage(ImageSource.gallery);
  _image = img;
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color primary = const Color(0xFFBBDEFB);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Profile'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://tse2.mm.bing.net/th?id=OIP.OnvcA-1dBpBRlJo6_p-nxAHaHa&pid=Api&P=0&h=180'),
                          ),
                    const Positioned(
                      bottom: -5,
                      left: 70,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: 'Department',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    labelText: 'Position',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _phonenumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _positionController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty &&
                        _phonenumberController.text.isNotEmpty) {
                      Employee newEmployee = Employee(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _nameController.text,
                          email: _emailController.text,
                          position: _positionController.text,
                          address: _addressController.text,
                          phonenumber: _phonenumberController.text,
                          department: _departmentController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetailsPage(
                            employee: newEmployee,
                            profileImage: _image,
                          ),
                        ),
                      );
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  child: Container(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: const Text(
                      'Register ',
                      style: TextStyle(fontSize: 20),
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
