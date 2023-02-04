import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork_barcode/pages/detail_page.dart';
import 'package:upwork_barcode/providers/book_provider.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  TextEditingController productCodeController = TextEditingController();
  bool isError = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    productCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bookProvider = Provider.of<BookProvider>(context, listen: false);

    void _onTap() async {
      setState(() {
        isLoading = true;
        isError = false;
      });
      await bookProvider
          .getProduct(productCodeController.text)
          .then((isSuccess) {
        if (isSuccess == false) {
          setState(() {
            isLoading = false;
            isError = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailPage()),
          );
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          TextField(
            controller: productCodeController,
            maxLength: 13,
            keyboardType: TextInputType.number,
            onChanged: (newString) {
              setState(() {});
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Barcode",
              errorText: isError ? "Book with the barcode was not found" : null,
            ),
          ),
          GestureDetector(
            onTap: (isLoading)
                ? null
                : productCodeController.text.length == 13
                    ? _onTap
                    : null,
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: productCodeController.text.length == 13
                    ? Colors.blue
                    : const Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: (isLoading)
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Text(
                      "Artikel suchen",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: productCodeController.text.length == 13
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Die Barcode-Nummer befindet sich meist auf der Artikel­rückseite oder der Verpackung ober- oder unterhalb des Strich­codes. Viele Barcodes sind 13-stellig (EAN13) und bestehen größten­teils aus Ziffern. Produkt­bezeichnungen (z.B. der Buch­titel) werden leider nicht unter­stützt.",
            style: TextStyle(
              color: Colors.grey,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
