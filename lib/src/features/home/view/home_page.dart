import 'dart:developer';

import 'package:docu_scanner/src/core/router/routes.dart';
import 'package:docu_scanner/src/services/navigation_service/navigation_service.dart';
import 'package:docu_scanner/src/shared_widgets/image_view.dart';
import 'package:docu_scanner/src/shared_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigatorService = NavigationService();
  static const documentScannerChannel =
      MethodChannel("documentScannerPlatform");

  String data = "";

  Future<String> _runScanner() async {
    try {
      String result = await documentScannerChannel.invokeMethod('scan');

      log(result);

      return result;
    } on PlatformException catch (e) {
      log("Failure: ${e.message}");
      return "Scan Result: Error while scanning document";
    } catch (e) {
      log("Failure: Scan Faiiilllleddddd");
      return "Scan Result: Error while scanning document";
    }
  }

  bool isImageDataAvailable() {
    return data != "" && !data.contains("Error");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Document Scanner"),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: !isImageDataAvailable()
                      ? SizedBox(
                          child: Text(data),
                        )
                      : SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 500,
                          child: ImageView(
                            text: data,
                          ),
                        ),
                ),
                isImageDataAvailable()
                    ? ElevatedButton(
                        onPressed: () {
                          print("Pressed!!!");
                          Navigator.pushNamed(
                            context,
                            Routes.imageDisplay,
                            arguments: data,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.sizeOf(context).width * 0.8,
                            48,
                          ),
                        ),
                        child: const Text("View"),
                      )
                    : const Spacing.empty(),
                const Spacing.smallHeight(),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      data = "";
                    });
                    data = await _runScanner();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.sizeOf(context).width * 0.8,
                      48,
                    ),
                  ),
                  child: const Text("Scan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
