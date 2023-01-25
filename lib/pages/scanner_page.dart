import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // } else if (Platform.isIOS) {
    //   controller!.resumeCamera();
    // }
    controller!.resumeCamera();
    // controller!.
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller!.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> startBarcodeScanStream() async {
    //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
    //           '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
    //       .listen((barcode) => print(barcode));
    // }

    return Column(
      children: <Widget>[
        // ElevatedButton(
        //   onPressed: () {
        //     startBarcodeScanStream();
        //   },
        //   child: Text("barcode stream"),
        // ),
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
                ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                : Text('Scan a code'),
          ),
        )
      ],
    );
  }
}
