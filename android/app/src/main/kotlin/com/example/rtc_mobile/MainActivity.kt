package com.example.rtc_mobile

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val DOWNLOADS_CHANNEL = "com.rtc_mobile/downloads"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DOWNLOADS_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "saveToDownloads") {
                val fileName = call.argument<String>("fileName") ?: ""
                val bytes   = call.argument<ByteArray>("bytes") ?: byteArrayOf()
                try {
                    val path = saveFileToDownloads(fileName, bytes)
                    result.success(path)
                } catch (e: Exception) {
                    result.error("SAVE_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun saveFileToDownloads(fileName: String, bytes: ByteArray): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val values = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, "$fileName.pdf")
                put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
                put(MediaStore.Downloads.IS_PENDING, 1)
            }
            val resolver = applicationContext.contentResolver
            val uri = resolver.insert(
                MediaStore.Downloads.EXTERNAL_CONTENT_URI, values
            ) ?: throw Exception("MediaStore insert failed")

            resolver.openOutputStream(uri)?.use { it.write(bytes) }
                ?: throw Exception("openOutputStream failed")

            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)

            "/storage/emulated/0/Download/$fileName.pdf"
        } else {
            val dir  = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
            val file = File(dir, "$fileName.pdf")
            FileOutputStream(file).use { it.write(bytes) }
            file.absolutePath
        }
    }
}
