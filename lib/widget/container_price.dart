import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContainerPrice extends StatelessWidget {
  const ContainerPrice(
      {Key? key,
      required this.vendor,
      required this.price,
      required this.website})
      : super(key: key);

  final String vendor;
  final double price;
  final String website;

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
          const Spacer(),
          Text("$price €"),
          IconButton(
            onPressed: () async {
              if (!await launchUrlString(website,
                  mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $website');
              }
            },
            icon: const Icon(Icons.open_in_new),
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }
}
