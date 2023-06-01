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
      applicationId: '',
      methodId: '1001',
      versionNo: '1.0',
      userId: '1234',
    ),
  );
  late TextEditingController _controller;
  late TextEditingController _setBluetoothController;
  TransactionType _transactionType = TransactionType.cash;
  String _responseMessage = '';
  String _bluetoothResponseMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _setBluetoothController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _setBluetoothController.dispose();
    super.dispose();
  }

  Future<void> _setBluetooth(String serialNumber) async {
    /// do transaction for pinelabs device.
    /// calls the pinelab device with the header provided in the constructor.
    /// one can override the contructor using [overrideHeader] parameter.
    print(serialNumber);
    final response = await _flutterPinelabsPlugin.setBluetooth(
      baseSerialNumber: serialNumber,
    );

    print(response.toString());

    /// provides ResponseModel in return which contains the response from the pinelabs device.
    setState(() {
      _bluetoothResponseMessage = (response ?? '').toString();
    });
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

  String _organizeName(String name) {
    final words = name.split(" ");
    StringBuffer line = StringBuffer();
    final result = StringBuffer();

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      if (line.length + word.length > 16) {
        //add line to result if it full
        result
          ..write(line)
          ..write('\n');
        line = StringBuffer(); //reset line is empty
      }
      line.write(word);
      if (i == (words.length - 1)) {
        line.write(" ".padRight(line.length >= 16 ? 0 : (16 - words.length)));
      } else {
        line.write(" ");
      }
    }
    result.write(line);

    return result.toString();
  }

  Future<void> _printData() async {
    final rowData = [
      {'name': 'test product', 'qty': '2', 'price': '\$200'},
      {'name': 'dosa', 'qty': '15', 'price': '\$10'},
      {
        'name': 'SOME BRAND awesome product that keeps your mind cool',
        'qty': '2',
        'price': '\$200'
      },
      {'name': 'test product', 'qty': '100', 'price': '\$10000'},
    ];
    final List<PrintRowModel> printRows = rowData.map((e) {
      final name = e['name']!;
      final qty = e['qty']!;
      final price = e['price']!;
      e['name'] = name.length > 12 ? _organizeName(name) : name.padRight(16);
      e['qty'] = qty.padRight(7);
      e['price'] = price.padRight(9);
      return PrintRowModel(
        printDataType: '0',
        printerWidth: 32,
        dataToPrint: '${e['name']}${e['qty']}${e['price']}',
        imageData: '0',
        imagePath: '0',
        isCenterAligned: false,
      );
    }).toList();

    final request = PrintModel(
      printRefNo: '1234',
      savePrintData: true,
      data: [
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 24,
          isCenterAligned: true,
          dataToPrint: 'Test Bill',
          imageData: '0',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 48,
          dataToPrint: '------------------------------------------------',
          imageData: '0',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 24,
          dataToPrint: 'Items     Qty     Cost',
          imageData: '0',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 48,
          dataToPrint: '------------------------------------------------',
          imageData: '0',
          imagePath: '0',
        ),
        ...printRows,
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 48,
          dataToPrint: '------------------------------------------------',
          imageData: '0',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 24,
          dataToPrint: 'Total:     \$5000',
          imageData: '',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 48,
          dataToPrint: '------------------------------------------------',
          imageData: '0',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 32,
          dataToPrint: 'Thank You For Shopping With Us',
          imageData: '',
          imagePath: '0',
        ),
        const PrintRowModel(
          printDataType: '0',
          printerWidth: 24,
          dataToPrint: '\n',
          imageData: '',
          imagePath: '0',
        ),
      ],
    );
    final response = await _flutterPinelabsPlugin.printData(
      overrideHeader: const HeaderModel(
        applicationId: 'your pinelab app id',
        methodId: '1002',
        versionNo: '1.0',
      ),
      printRequest: request,
    );

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      const Text('Transaction Related Operations'),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(hintText: 'Enter amount'),
                        keyboardType: TextInputType.number,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Do transaction'),
                            onPressed: () async {
                              double amount =
                                  double.tryParse(_controller.text) ?? 0;
                              _responseMessage = '';
                              await _doTransaction(amount);
                            },
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            child: const Text('Print Data'),
                            onPressed: () async {
                              await _printData();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Running on: $_responseMessage\n'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      const Text('Bluetooth Related Operations'),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _setBluetoothController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Base Serial Number',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: const Text('Set Bluetooth'),
                        onPressed: () async {
                          _bluetoothResponseMessage = '';
                          await _setBluetooth(_setBluetoothController.text);
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Bluetooth response: $_bluetoothResponseMessage\n',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
