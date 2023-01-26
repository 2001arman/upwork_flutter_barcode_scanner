import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upwork_barcode/pages/detail_page.dart';
import 'package:upwork_barcode/providers/book_provider.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isLoading = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller?.resumeCamera();
  }

  void getBook(String code) async {
    setState(() {
      isLoading = true;
    });
    await context.read<BookProvider>().getProduct(code).then((isSuccess) {
      setState(() {
        isLoading = false;
      });

      if (isSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailPage()),
        );
      } else {
        final snackBar = SnackBar(
          content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Center(
                  child: Text('Book with the barcode was not found'))),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      String searchCode = scanData.code.toString();
      getBook(searchCode);

      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void initState() {
    controller?.resumeCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? (isLoading == false)
                        ? ElevatedButton(
                            onPressed: () {
                              controller?.resumeCamera();
                              result = null;
                              setState(() {});
                            },
                            child: const Text("Scan Again"),
                          )
                        : null
                    : const Text('Scan a code'),
              ),
            )
          ],
        ),
        (isLoading)
            ? Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
