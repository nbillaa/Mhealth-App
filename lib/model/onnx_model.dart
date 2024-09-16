import 'package:flutter/services.dart';

class OnnxModel {
  static const platform = MethodChannel('onnx_model_channel');

  // Method untuk menjalankan model ONNX
  Future<List<double>> runModel(List<double> input) async {
    try {
      // Kirim data sebagai List<double>
      final List<dynamic> result = await platform.invokeMethod('runModel', {'input': input});
      // Konversi hasil dari dynamic ke double
      return result.map((e) => (e as num).toDouble()).toList();
    } on PlatformException catch (e) {
      print("Failed to run model: '${e.message}'");
      return [];
    }
  }
}
