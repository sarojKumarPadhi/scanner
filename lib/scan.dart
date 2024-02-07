import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  TextEditingController urlController = TextEditingController();
  String dataString = '';
  List<String> dataList = [];
  String qrResult = 'Scanned Data will apper here';

  Future<void> scanQr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
        this.dataList =
            qrCode.toString().split('|'); // Split the scanned data into a list
      });
    } on PlatformException {
      qrResult = 'Fail to read QR Code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code scanner"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            '$qrResult',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await scanQr();
              },
              child: const Text("Scan Code")),
          ElevatedButton(
              onPressed: () async {
                final res = await EasyUpiPaymentPlatform.instance.startPayment(
                  EasyUpiPaymentModel(
                    payeeVpa: dataList[0],
                    payeeName: dataList[1],
                    amount: double.parse(dataList[2]),
                    description: dataList[3],
                  ),
                );
                print(res);
              },
              child: const Text("Pay Now")),
        ],
      )),
    );
  }
}
