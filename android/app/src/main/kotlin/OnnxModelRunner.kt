package com.example.mental_health_app

import ai.onnxruntime.*
import android.util.Log
import java.util.Collections // Tambahkan ini untuk mengimpor Collections

class OnnxModelRunner {
    private var session: OrtSession? = null
    private val env: OrtEnvironment = OrtEnvironment.getEnvironment()

    init {
        try {
            session = env.createSession("model_xgboost.onnx") // Ganti dengan path ke model ONNX
        } catch (e: OrtException) {
            Log.e("OnnxModelRunner", "Failed to create ONNX session", e)
        }
    }

    fun runModel(input: FloatArray): FloatArray? {
        return try {
            val tensor = OnnxTensor.createTensor(env, arrayOf(input))
            val result = session?.run(Collections.singletonMap("input", tensor)) // Menggunakan Collections.singletonMap
            result?.get(0)?.value as? FloatArray
        } catch (e: OrtException) {
            Log.e("OnnxModelRunner", "Failed to run model", e)
            null
        }
    }

    // Forward Chaining and Certainty Factor methods
    fun applyForwardChainingAndCF(gejala: Map<String, Float>, rules: List<Rule>): Map<String, Float> {
        val results = mutableMapOf<String, Float>()

        // Implementasikan logika Forward Chaining dan Certainty Factor di sini
        // Contoh placeholder
        // results["ExampleResult"] = 1.0f

        return results
    }
}

data class Rule(val condition: String, val result: String, val cf: Float)
