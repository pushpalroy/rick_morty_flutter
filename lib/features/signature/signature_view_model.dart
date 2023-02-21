import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureViewModel extends ChangeNotifier {
  final GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();

  Future<void> saveSignature() async {
    final image = await signaturePadKey.currentState!.toImage();
    // TODO: handle image (save or send via API)
  }

  void clearSignaturePad() {
    signaturePadKey.currentState?.clear();
  }
}
