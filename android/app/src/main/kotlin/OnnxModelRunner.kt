package com.example.mental_health_app

import ai.onnxruntime.OnnxTensor
import ai.onnxruntime.OrtEnvironment
import ai.onnxruntime.OrtException
import ai.onnxruntime.OrtSession
import android.util.Log
import java.util.Collections

class OnnxModelRunner {
    private var session: OrtSession? = null
    private val env: OrtEnvironment = OrtEnvironment.getEnvironment()

    init {
        try {
            session = env.createSession("model_xgboost.onnx") // Sesuaikan path model ONNX
        } catch (e: OrtException) {
            Log.e("OnnxModelRunner", "Failed to create ONNX session", e)
        }
    }

    fun runModel(input: List<Double>): FloatArray? {
        return try {
            val inputArray = input.map { it.toFloat() }.toFloatArray() // Konversi ke FloatArray
            val tensor = OnnxTensor.createTensor(env, arrayOf(inputArray))
            Log.d("OnnxModelRunner", "Input tensor: ${tensor.toString()}")
            val result = session?.run(Collections.singletonMap("input", tensor))
            val output = result?.get(0)?.value as? FloatArray
            Log.d("OnnxModelRunner", "Result: ${output?.toList()}")
            output
        } catch (e: OrtException) {
            Log.e("OnnxModelRunner", "Failed to run model", e)
            null
        }
    }
}
