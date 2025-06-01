import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; 
import '../controllers/vigile_controller.dart';
import 'package:ges_absence/theme/app_theme.dart';
import 'package:ges_absence/theme/colors.dart';

class VigileScanView extends GetView<VigileController> {
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SwitchListTile(
                    title: Text(
                      controller.isScanning.value
                          ? 'Mode Scanner (QR)'
                          : 'Mode Manuel (Matricule)',
                      style: AppTheme.subtitleStyle,
                    ),
                    value: controller.isScanning.value,
                    onChanged: (value) {
                      controller.toggleScanMode();
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.brown,
                  ),
                ),
              ),

            ],
          )),
    );
  }
}
