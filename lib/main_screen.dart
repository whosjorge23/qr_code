import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-scren';
  const MainScreen({Key? key}) : super(key: key);

  final bool _text = false;

  @override
  Widget build(BuildContext context) {
    final dataRoute = ModalRoute.of(context)!.settings.arguments as Barcode;
    final exportedData = dataRoute.code;
    final convertedData = json.decode(exportedData as String);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${convertedData['username']}"),
        // title: Text("Welcome username"),
      ),
      body: Center(
        child: !_text
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Text("Getway IP: ${convertedData['gateway_ip']}"),
                    // Text("API URL: ${convertedData['api_url']}"),
                    // Text(
                    //     "Auth Token: ${convertedData['local_temp_auth_token']}"),
                    Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        child:
                            Text("Gateway IP: ${convertedData['gateway_ip']}"),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        child: Text("API URL: ${convertedData['api_url']}"),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        child: Text(
                            "Auth Token: ${convertedData['local_temp_auth_token']}"),
                      ),
                    ),
                  ],
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                children: [
                  Card(
                    child: Center(
                      child: Text("Item 0"),
                    ),
                  ),
                  Card(
                    child: Center(
                      child: Text("Item 1"),
                    ),
                  ),
                  Card(
                    child: Center(
                      child: Text("Item 2"),
                    ),
                  ),
                  Card(
                    child: Center(
                      child: Text("Item 3"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
