// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import '../controllers/vigile_home_controller.dart';
// import 'package:ges_absence/theme/app_theme.dart';
// import 'package:ges_absence/theme/colors.dart';

// class VigileScanView extends GetView<VigileHomeController> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   final _matriculeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scanner Étudiant', style: AppTheme.appBarStyle),
//         backgroundColor: const Color(0xFF8B4513),
//       ),
//       body: Obx(() => Column(
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: controller.isScanning.value
//                     ? QRView(
//                         key: qrKey,
//                         onQRViewCreated: (QRViewController qrController) {
//                           qrController.scannedDataStream.listen((scanData) {
//                             if (scanData.code != null) {
//                               controller.scanQRCode(scanData.code!);
//                               qrController.pauseCamera();
//                             }
//                           });
//                         },
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: TextFormField(
//                           controller: _matriculeController,
//                           decoration: InputDecoration(
//                             labelText: 'Matricule',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onFieldSubmitted: (value) =>
//                               controller.searchByMatricule(value),
//                         ),
//                       ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Center(
//                   child: Switch(
//                     value: controller.isScanning.value,
//                     onChanged: (value) {
//                       controller.toggleScanMode();
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Nouveau package
import '../controllers/vigile_home_controller.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';

class VigileScanView extends GetView<VigileHomeController> {
  final _matriculeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner Étudiant', style: AppTheme.appBarStyle),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                flex: 5,
                child: controller.isScanning.value
                ? MobileScanner(
                onDetect: (BarcodeCapture capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    final String? code = barcode.rawValue;
                    if (code != null) {
                      controller.scanQRCode(code);
                      controller.toggleScanMode(); 
                      break; 
                    }
                  }
                },
               )

                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _matriculeController,
                          decoration: InputDecoration(
                            labelText: 'Matricule',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onFieldSubmitted: (value) =>
                              controller.searchByMatricule(value),
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Switch(
                    value: controller.isScanning.value,
                    onChanged: (value) {
                      controller.toggleScanMode();
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
