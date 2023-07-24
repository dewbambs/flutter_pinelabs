import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _scanResponseMessage = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _controller = TextEditingController();
    _setBluetoothController = TextEditingController(text: '1990497297');
  }

  @override
  void dispose() {
    _controller.dispose();
    _setBluetoothController.dispose();
    super.dispose();
  }

  String _platformVersion = 'Unknown';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterPinelabsPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
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

  Future<void> _setBluetooth(String serialNumber) async {
    /// do transaction for pinelabs device.
    /// calls the pinelab device with the header provided in the constructor.
    /// one can override the contructor using [overrideHeader] parameter.
    final response = await _flutterPinelabsPlugin.setBluetooth(
      baseSerialNumber: serialNumber,
    );

    /// provides ResponseModel in return which contains the response from the pinelabs device.
    setState(() {
      _bluetoothResponseMessage = (response?.rawResponse ?? '').toString();
    });
  }

  /// Start Scan after successfull bluetooth connections
  Future<void> _startScan(String serialNumber) async {
    /// do transaction for pinelabs device.
    /// calls the pinelab device with the header provided in the constructor.
    /// one can override the contructor using [overrideHeader] parameter.
    final response = await _flutterPinelabsPlugin.startScan(
      baseSerialNumber: serialNumber,
    );

    /// provides ResponseModel in return which contains the response from the pinelabs device.
    setState(() {
      _scanResponseMessage = (response?.rawResponse ?? '').toString();
    });
  }

  /// Stop Scan Method
  Future<void> _stopScan(String serialNumber) async {
    /// do transaction for pinelabs device.
    /// calls the pinelab device with the header provided in the constructor.
    /// one can override the contructor using [overrideHeader] parameter.
    final response = await _flutterPinelabsPlugin.stopScan(
      baseSerialNumber: serialNumber,
    );

    /// provides ResponseModel in return which contains the response from the pinelabs device.
    setState(() {
      _scanResponseMessage = (response?.rawResponse ?? '').toString();
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
                Center(
                  child: Text('Running on: $_platformVersion\n'),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                              _responseMessage = 'Processing Payment';
                              setState(() {});
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
                      Text('Transaction Response : $_responseMessage\n'),
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
                      const SizedBox(height: 10),
                      const Text(
                        '(Configured for : 1990497297)',
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        enabled: false,
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
                          _bluetoothResponseMessage = 'Pairing Bluetooth';
                          setState(() {});
                          // await _setBluetooth(_setBluetoothController.text);
                          await _setBluetooth('1990497297');
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Bluetooth response: $_bluetoothResponseMessage\n',
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Scan Related Operations'),
                      const SizedBox(height: 10),
                      const Text(
                        '(Configured for : 1990497297)',
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Start Scan'),
                            onPressed: () async {
                              _scanResponseMessage =
                                  'Scan Started, awaiting response... !';
                              setState(() {});
                              await _startScan('1990497297');
                            },
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            child: const Text('Stop Scan'),
                            onPressed: () async {
                              _scanResponseMessage =
                                  'Stop Scan Method Triggered, awaiting response... !';
                              setState(() {});
                              await _stopScan('1990497297');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Scan response: $_scanResponseMessage\n',
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
