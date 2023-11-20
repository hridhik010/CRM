import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchEmployeeData() async {
  try {
    final QuerySnapshot employeeData =
        await FirebaseFirestore.instance.collection('employees').get();

    for (QueryDocumentSnapshot doc in employeeData.docs) {
      final data = doc.data();
      // Process and use the data as needed
      print(data); // Example: Print the data to the console
    }
  } catch (e) {
    print('Error fetching employee data: $e');
  }
}
