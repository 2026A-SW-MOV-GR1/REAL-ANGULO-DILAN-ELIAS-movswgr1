package com.example.moviles2026aswgr1

import android.content.res.Configuration
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.moviles2026aswgr1/resources"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getResourceString" -> {
                        val resourceName = call.argument<String>("resourceName")
                        val value = getStringResource(resourceName)
                        result.success(value)
                    }
                    "getResourceColor" -> {
                        val colorName = call.argument<String>("colorName")
                        val value = getColorResource(colorName)
                        result.success(value)
                    }
                    "getConfiguration" -> {
                        val config = mapOf(
                            "language" to getLanguage(),
                            "orientation" to getOrientation()
                        )
                        result.success(config)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getStringResource(resourceName: String?): String {
        return try {
            val resId = resources.getIdentifier(resourceName, "string", packageName)
            if (resId != 0) getString(resId) else "NOT_FOUND"
        } catch (e: Exception) {
            "ERROR: ${e.message}"
        }
    }

    private fun getColorResource(colorName: String?): Int {
        return try {
            val resId = resources.getIdentifier(colorName, "color", packageName)
            if (resId != 0) resources.getColor(resId, theme) else -1
        } catch (e: Exception) {
            -1
        }
    }

    private fun getLanguage(): String {
        return resources.configuration.locales[0].language
    }

    private fun getOrientation(): String {
        return when (resources.configuration.orientation) {
            Configuration.ORIENTATION_PORTRAIT -> "portrait"
            Configuration.ORIENTATION_LANDSCAPE -> "landscape"
            else -> "unknown"
        }
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        // El cambio de configuración se detectará en Flutter
    }
}

