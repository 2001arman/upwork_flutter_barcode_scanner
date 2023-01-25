import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bookSection() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            Image.network(
              "https://d1o0zx25fn5p70.cloudfront.net/M9jxqudoLhDUKP7c9U-jLYadLYg=/fit-in/350x350/noupscale/assets.rebuy.de/products/001/447/026/covers/main.jpeg?t=1673855924",
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "The Duck and the Owl - Hanna Johansen",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "9783473520985",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Offer"),
        elevation: 0,
      ),
      body: Column(
        children: [bookSection(), Container()],
      ),
    );
  }
}
