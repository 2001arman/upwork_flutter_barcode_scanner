import 'package:flutter/material.dart';

class ContainerPrice extends StatelessWidget {
  const ContainerPrice({Key? key, required this.vendor, required this.price})
      : super(key: key);

  final String vendor;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromARGB(255, 211, 211, 211),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: "$vendor\n",
              style: const TextStyle(color: Colors.black),
              children: const [
                TextSpan(
                  text: "just now",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text("€$price"),
        ],
      ),
    );
  }
}
