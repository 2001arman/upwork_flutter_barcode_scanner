import 'package:flutter/material.dart';
import 'package:upwork_barcode/widget/container_price.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String rateItemRadio = "Very good";
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

    Widget priceSection() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
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
                  Image.asset(
                    "assets/pricetag.png",
                    width: 50,
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    text: const TextSpan(
                      text: "Purchase prices\n",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "€0.01 - €0.47",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ContainerPrice(vendor: "reBuy.de", price: 0.47),
            const ContainerPrice(vendor: "zoxs.de", price: 0.01),
          ],
        ),
      );
    }

    Widget conditionSection() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Rate the item condition",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text("Like new"),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  leading: Radio(
                    value: "Like new",
                    groupValue: rateItemRadio,
                    onChanged: (newValue) {
                      setState(() {
                        rateItemRadio = newValue.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Very good"),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  leading: Radio(
                    value: "Very good",
                    groupValue: rateItemRadio,
                    onChanged: (newValue) {
                      setState(() {
                        rateItemRadio = newValue.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Good"),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  leading: Radio(
                    value: "Good",
                    groupValue: rateItemRadio,
                    onChanged: (newValue) {
                      setState(() {
                        rateItemRadio = newValue.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Acceptable"),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  leading: Radio(
                    value: "Acceptable",
                    groupValue: rateItemRadio,
                    onChanged: (newValue) {
                      setState(() {
                        rateItemRadio = newValue.toString();
                      });
                    },
                  ),
                ),
              ],
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
      body: ListView(
        children: [
          bookSection(),
          priceSection(),
          conditionSection(),
        ],
      ),
    );
  }
}
