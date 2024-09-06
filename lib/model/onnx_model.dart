import 'package:flutter/services.dart';

class OnnxModel {
  static const platform = MethodChannel('onnx_model_channel');

  Future<List> runModel(List<double> input) async {
    try {
      final List<dynamic> result = await platform.invokeMethod('runModel', {'input': input});
      return result.map((e) => e.toDouble()).toList();
    } on PlatformException catch (e) {
      print("Failed to run model: '${e.message}'.");
      return [];
    }
  }

  Future<Map<String, dynamic>> applyForwardChainingAndCF(Map<String, double> gejala, List<Map<String, dynamic>> rules) async {
    try {
      final Map<String, dynamic> result = await platform.invokeMethod('applyForwardChainingAndCF', {'gejala': gejala, 'rules': rules});
      return result;
    } on PlatformException catch (e) {
      print("Failed to apply Forward Chaining and CF: '${e.message}'.");
      return {};
    }
  }
}
