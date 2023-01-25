import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upwork_barcode/pages/detail_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailPage()),
      );
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
    return Column(
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
                ? ElevatedButton(
                    onPressed: () {
                      controller?.resumeCamera();
                      result = null;
                      setState(() {});
                    },
                    child: const Text("Scan Again"),
                  )
                : const Text('Scan a code'),
          ),
        )
      ],
    );
  }
}
