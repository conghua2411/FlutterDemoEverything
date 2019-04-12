package com.example.flutter_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import androidx.core.app.NotificationCompat
import com.googlecode.tesseract.android.TessBaseAPI

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity() {

    lateinit var ocrApi: TessBaseAPI

    override fun onCreate(savedInstanceState: Bundle?) {

        val channel = "com.example.flutter_app/main"

        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        ocrApi = TessBaseAPI()

        MethodChannel(flutterView, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "sayHello" -> {
                    result.success(sayHello())
                }
                "sayHello2" -> {
                    val imageCount = call.argument<Int>("imageCount")
                    result.success(sayHello2(imageCount as Int))
                }
                "testOcr" -> {
                    val imageFile = call.argument<File>("imageFile")
                    result.success(testOcr(imageFile))
                }
                "showNotification" -> {
//                    result.success(showNotification())
                    showNotification()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun sayHello(): String {
        return "hello there!!"
    }

    private fun sayHello2(imageCount: Int) : String {
        return "hello 2 image count : $imageCount"
    }

    private fun testOcr(image: File?) : String {
        return if (image == null) {
            ""
        } else {
            ocrApi.setImage(image)
//            NotificationCompat
            ocrApi.utF8Text
        }
    }

    private fun showNotification() {
        val nm: NotificationManager = this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val builder = NotificationCompat.Builder(this)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle("asdasdasdasd")
                .setContentText("asdasdasdasdasdasd")
                .setAutoCancel(true)
                .setPriority(NotificationCompat.PRIORITY_HIGH)

        // check android 8
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationChannel = NotificationChannel("wish_alarm_channel", "wish_channel", NotificationManager.IMPORTANCE_HIGH)
            notificationChannel.description = "wish channel"

            nm.createNotificationChannel(notificationChannel)

            builder.setChannelId("wish_alarm_channel")
        }

        nm.notify(0, builder.build())
    }
}
