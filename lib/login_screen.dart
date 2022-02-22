import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import './main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  String name = "";

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        controller.pauseCamera();
        final result = json.decode(barcode.code as String);
        this.name = result['username'];
        Navigator.of(context).pushNamed(
          MainScreen.routeName,
          arguments: barcode,
        );

        print(result['username']);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter QRCode Login"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  barcode = null;
                  controller?.resumeCamera();
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: buildControlButtons(),
          ),
          buildQrView(context),
          Positioned(
            bottom: 10,
            child: buildResult(),
          ),
        ],
      ),
    );
  }

  Widget buildControlButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: () async {
          //     await controller?.toggleFlash();
          //     setState(() {});
          //   },
          //   icon: FutureBuilder<bool?>(
          //     future: controller!.getFlashStatus(),
          //     builder: (context, snapshot) {
          //       if (snapshot.data != null) {
          //         return Icon(
          //             snapshot.data! ? Icons.flash_on : Icons.flash_off);
          //       } else {
          //         return Container();
          //       }
          //     },
          //   ),
          // ),
          // IconButton(
          //   onPressed: () async {
          //     await controller?.flipCamera();
          //     setState(() {});
          //   },
          //   icon: FutureBuilder<CameraFacing>(
          //     future: controller!.flipCamera(),
          //     builder: (context, snapshot) {
          //       if (snapshot.data != null) {
          //         return Icon(Icons.switch_camera);
          //       } else {
          //         return Container();
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      width: 300,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        barcode != null ? "Result: ${barcode!.code}" : "Scan a code",
        maxLines: 5,
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.amber,
        borderRadius: 10,
        borderWidth: 10,
        borderLength: 20,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
