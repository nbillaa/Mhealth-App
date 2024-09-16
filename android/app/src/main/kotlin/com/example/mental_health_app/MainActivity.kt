package com.example.mental_health_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "onnx_model_channel"
    private lateinit var onnxModelRunner: OnnxModelRunner

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        onnxModelRunner = OnnxModelRunner()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "runModel" -> {
                    // Mengambil data sebagai List<Double>
                    val input = call.argument<List<Double>>("input")
                    if (input != null) {
                        val output = onnxModelRunner.runModel(input)
                        if (output != null) {
                            result.success(output.toList())
                        } else {
                            result.error("ERROR", "Failed to run model", null)
                        }
                    } else {
                        result.error("ERROR", "Invalid input", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
