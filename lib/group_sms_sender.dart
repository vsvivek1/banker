import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:csv/csv.dart';
// import 'package:sms/sms.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_advanced/sms_advanced.dart';

class GroupSmsSender extends StatefulWidget {
  @override
  _GroupSmsSenderState createState() => _GroupSmsSenderState();
}

class _GroupSmsSenderState extends State<GroupSmsSender> {
  var selectedFile;
  // List<Map<String, dynamic>> fileData = [];
  var fileData = [];

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path as String);
      });

      if (selectedFile.path.endsWith('.csv')) {
        _readCsv();
      } else if (selectedFile.path.endsWith('.xlsx') ||
          selectedFile.path.endsWith('.xls')) {
        _readExcel();
      }
    }
  }

  Future<void> _readCsv() async {
    String fileContent = await selectedFile.readAsString();
    CsvToListConverter csvToListConverter = const CsvToListConverter();
    List<List<dynamic>> csvTable = csvToListConverter.convert(fileContent);

    print(csvTable);

    print('csv table above');
    List<String> headers = csvTable[0].map((cell) => cell.toString()).toList();

    print("file data below $fileData is file data");
    setState(() {
      csvTable.removeRange(0, 1);
      fileData = csvTable;

      ;

      // csvTable.sublist(1).map((row) {
      //   print(row);
      //   Map<String, dynamic> rowData = {};
      //   for (var i = 0; i < row.length; i++) {
      //     rowData[headers[i]] = row[i].toString();
      //   }
      //   return rowData;
      // }).toList();
    });
  }

  Future<void> _readExcel() async {
    // Read the Excel file and extract data
    // Implement this based on the excel package you are using
    // For example, using the excel package: https://pub.dev/packages/excel

    // Example code snippet to read Excel data
    // var bytes = await selectedFile.readAsBytes();
    // var excel = Excel.decodeBytes(bytes);
    // var sheet = excel.tables[excel.tables.keys.first];
    // ...
  }

//   void sendSms(String recipient, String message) {
//   // Get the TelephonyManager.
//   TelephonyManager telephonyManager =
//       await TelephonyManager.fromPlatform();

//   // Get the SMSManager.
//   SmsManager smsManager = SmsManager.getInstance();

//   // Send the message.
//   List<String> parts = smsManager.divideMessage(message);
//   for (String part in parts) {
//     smsManager.sendTextMessage(recipient, null, part, null, null);
//   }
// }

  Future<void> _sendGroupSms() async {
    // SmsQuery query = SmsQuery();
    // List<SmsMessage> messages = await query.getAllSms;

    // print(messages);
    print('mesage above');
    print('from send group sms');

    print(fileData);
    print("$fileData is from file send sms");
    for (var data in fileData) {
      print("$data is here");
      String phoneNumber = data[0].toString();
      String name = data[1].toString();
      String amount = data[2].toString();
      String lastDate = data[3].toString();

      String message =
          'Dear $name, you have a due of $amount to settle before $lastDate. Regards, Bank';

      // SmsSender sender = SmsSender();
      // SmsMessage smsMessage = SmsMessage(phoneNumber, message);
      // sender.sendSms(smsMessage);

      //  String message = "This is a test message!";
      List<String> recipents = [phoneNumber];

// try{

      SmsSender sender = SmsSender();
      String address = phoneNumber;

      print('just before action $address');

      sender.sendSms(SmsMessage(address, message));

      print(message);

      //  SmsSender sender = SmsSender();

// SmsMessage msg=SmsMessage(_address, _body)

      // var sent = await sender.sendSms(msg)

      //  sender.sendSms(recipents, message);

      // bool sentBool = sent != null;

      // try {
      //   await sendSMS(message: message, recipients: recipents);
      //   print('SMS sent to $phoneNumber');
      // } on PlatformException catch (e) {
      //   print('Failed to send SMS: ${e.message}');
      //   // Handle the error gracefully, such as showing a snackbar or displaying an error message to the user
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Failed to send SMS: ${e.message}'),
      //     ),
      //   );
      // }

// } catch((e) {
//         print(onError);
//       });

      // print(_result);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Group SMS sent to all recipients'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group SMS Sender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            Text(
              selectedFile != null
                  ? path.basename(selectedFile.path)
                  : 'No file selected',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fileData.isNotEmpty ? _sendGroupSms : null,
              child: Text('Send Group SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
