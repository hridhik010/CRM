import 'package:flutter/material.dart';

class Check_in_Out_widget extends StatelessWidget {
  final String? check_in_time;

  final String? check_in_out;
  const Check_in_Out_widget(
      {super.key, required this.check_in_time, required this.check_in_out});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Check In",
                  style: TextStyle(
                      fontFamily: "NexaRegular",
                      fontSize: 20,
                      color: Colors.black54),
                ),
                Text(
                  check_in_time ?? "",
                  style: const TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Check Out",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: 20,
                        color: Colors.black54),
                  ),
                  Text(check_in_out ?? "",
                      style: const TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 18,
                      )),
                ]),
          )
        ],
      ),
    );
  }
}
