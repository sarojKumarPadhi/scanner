import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenrateQrCode extends StatefulWidget {
  const GenrateQrCode({super.key});

  @override
  State<GenrateQrCode> createState() => _GenrateQrCodeState();
}

class _GenrateQrCodeState extends State<GenrateQrCode> {
  TextEditingController urlController = TextEditingController();
  String dataString = '';
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genearte qr code "),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (urlController.text.isNotEmpty)
            QrImageView(
              data: dataString,
              size: 200,
            ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                  hintText: "Enter amount to be paid",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Enter amout to be paid'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  List<String> dataList = [
                    'surajpadhi01@oksbi',
                    'Saroj kumar Padhi',
                    urlController.text,
                    'Testing payment'
                  ];
                  dataString = dataList.join('|');
                });
              },
              child: const Text("Generate Qr Code")),
        ]),
      ),
    );
  }
}
