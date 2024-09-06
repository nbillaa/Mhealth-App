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
                    val input = call.argument<FloatArray>("input")
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
                "applyForwardChainingAndCF" -> {
                    val gejala = call.argument<Map<String, Float>>("gejala") ?: emptyMap()
                    val rules = call.argument<List<Map<String, Any>>>("rules")?.mapNotNull {
                        val condition = it["condition"] as? String
                        val result = it["result"] as? String
                        val cf = (it["cf"] as? Number)?.toFloat()
                        if (condition != null && result != null && cf != null) {
                            Rule(condition, result, cf)
                        } else {
                            null
                        }
                    } ?: emptyList()

                    val chainingResult = onnxModelRunner.applyForwardChainingAndCF(gejala, rules)
                    if (chainingResult != null) {
                        result.success(chainingResult)
                    } else {
                        result.error("ERROR", "Failed to apply rules", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
