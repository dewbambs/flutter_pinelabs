import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_pinelabs/flutter_pinelabs_module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterPinelabsPlugin = const FlutterPinelabs(
    header: HeaderModel(
      applicationId: 'your application id.',
      methodId: '1001',
      versionNo: '1.0',
    ),
  );
  late TextEditingController _controller;
  TransactionType _transactionType = TransactionType.cash;
  String _responseMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _doTransaction(double amount) async {
    /// do transaction for pinelabs device.
    /// calls the pinelab device with the header provided in the constructor.
    /// one can override the contructor using [overrideHeader] parameter.
    final response = await _flutterPinelabsPlugin.doTransaction(
      transactionType: _transactionType,
      billingRefNo: '12345',
      paymentAmount: amount,
      mobileNumberForEChargeSlip: '1234567890',
    );

    /// provides ResponseModel in return which contains the response from the pinelabs device.
    setState(() {
      _responseMessage = response?.responseMsg ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter amount'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<TransactionType>(
              value: _transactionType,
              items: TransactionType.values
                  .map(
                    (e) => DropdownMenuItem<TransactionType>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                if (e == null) return;

                setState(() {
                  _transactionType = e;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Send request'),
              onPressed: () async {
                double amount = double.tryParse(_controller.text) ?? 0;
                _doTransaction(amount);
              },
            ),
            const SizedBox(height: 20),
            Text('Running on: $_responseMessage\n'),
          ],
        ),
      ),
    );
  }
}
