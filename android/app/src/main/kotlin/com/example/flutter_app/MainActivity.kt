package com.example.flutter_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.Intent.getIntent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.NotificationCompat
import com.googlecode.tesseract.android.TessBaseAPI

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import android.content.ContentValues.TAG
import android.os.Environment
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin.showNotification
import io.flutter.plugin.common.EventChannel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.subjects.PublishSubject
import java.util.logging.StreamHandler
import com.amazonaws.mobile.client.UserStateDetails
import com.amazonaws.mobile.client.AWSMobileClient
import com.amazonaws.mobile.client.Callback
import com.amazonaws.mobile.client.UserState
import com.amazonaws.mobile.client.results.SignInResult
import com.amazonaws.mobileconnectors.s3.transferutility.*
import com.amazonaws.services.s3.AmazonS3Client
import java.lang.Exception


class MainActivity : FlutterActivity() {

    val TAG = "MainActivity"

    lateinit var ocrApi: TessBaseAPI

    val compositeDisposable = CompositeDisposable()

    val publishSubject = PublishSubject.create<String>()

    override fun onCreate(savedInstanceState: Bundle?) {

        val channel = "com.example.flutter_app/main"
        val STREAM = "com.example.flutter_app/main"

        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        // aws s3
        applicationContext.startService(Intent(applicationContext, TransferService::class.java))

        AWSMobileClient.getInstance().initialize(applicationContext, object : Callback<UserStateDetails> {
            override fun onResult(result: UserStateDetails?) {
                Log.i(TAG, "AWSMobileClient initialized. User State is " + result?.userState)
                if (result?.userState == UserState.SIGNED_IN) {
                    Log.d(TAG, "USER SIGNED IN")
                } else {
                    Log.d(TAG, "userState: ${result?.userState}")
//                    signin()
                }
            }

            override fun onError(e: Exception?) {
                Log.e(TAG, "Initialization error.", e)
            }
        })

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
                "uploadImage" -> {
                    uploadImage()
                }
                "signOutCognito" -> {
                    signOutCognito()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

//        EventChannel(flutterView, STREAM).setStreamHandler(
//                object : EventChannel.StreamHandler {
//                    override fun onListen(args: Any, events: EventChannel.EventSink) {
//                        Log.w(TAG, "adding listener")
//
//                        compositeDisposable.add(
//                                publishSubject
//                                        .observeOn(AndroidSchedulers.mainThread())
//                                        .subscribe {
//                                            if (it == null) {
//                                                events.success("email is null")
//                                            } else {
//                                                Log.d("deepLink", "onNext : $it")
//                                                events.success(it)
//                                            }
//                                        })
//
////                        events.success("hello")
//                    }
//
//                    override fun onCancel(args: Any) {
//                        Log.w(TAG, "cancelling listener")
//                    }
//                }
//        )
    }

    private fun signOutCognito() {
        AWSMobileClient.getInstance().signOut()
    }

    private fun uploadImage() {
//        uploadWithTransferUtility()

        if (AWSMobileClient.getInstance().isSignedIn) {
            uploadWithTransferUtility()
        } else {
            signin()
        }

//        AWSMobileClient.getInstance().initialize(applicationContext, object : Callback<UserStateDetails> {
//            override fun onResult(result: UserStateDetails?) {
//                Log.i(TAG, "AWSMobileClient initialized. User State is " + result?.userState)
//                if (result?.userState == UserState.SIGNED_IN) {
//                    Log.d(TAG, "USER SIGNED IN")
//                    uploadWithTransferUtility()
//                } else {
//                    Log.d(TAG, "userState: ${result?.userState}")
//                    signin()
//                }
//            }
//
//            override fun onError(e: Exception?) {
//                Log.e(TAG, "Initialization error.", e)
//            }
//        })
    }

    private fun signin() {
        AWSMobileClient.getInstance().signIn("conghua2411@yopmail.com", "111111", null, object : Callback<SignInResult> {
            override fun onResult(result: SignInResult?) {
                Log.d(TAG, "signin: ${result?.signInState}")
                uploadWithTransferUtility()
            }

            override fun onError(e: Exception?) {
                Log.d(TAG, "Error: ${e.toString()}")
            }
        })
    }

    private fun uploadWithTransferUtility() {

//        Log.d(TAG,"uploadWithTransferUtility user State : ${AWSMobileClient.getInstance().currentUserState()}")

        System.out.print("$TAG uploadWithTransferUtility user State : ${AWSMobileClient.getInstance().currentUserState()}")

        val transferUtility = TransferUtility.builder()
                .defaultBucket("crypto-badge-static-m1")
                .context(applicationContext)
                .awsConfiguration(AWSMobileClient.getInstance().configuration)
                .s3Client(AmazonS3Client(AWSMobileClient.getInstance()))
                .build()

        TransferNetworkLossHandler.getInstance(applicationContext)

        val uploadObserver =
                transferUtility.upload(
                        "protected/${AWSMobileClient.getInstance().identityId}/abc123123.jpg",
                        File("${Environment.getExternalStorageDirectory().path}/Pictures/1536807835610.jpg")
//                        File("${Environment.getExternalStorageDirectory().path}/Pictures/Screenshots/abc.png")
                )
        uploadObserver.setTransferListener(object : TransferListener {
            override fun onProgressChanged(id: Int, bytesCurrent: Long, bytesTotal: Long) {
                val percentDonef = bytesCurrent.toFloat() / bytesTotal.toFloat() * 100
                val percentDone = percentDonef.toInt()

                Log.d("YourActivity", "ID:" + id + " bytesCurrent: " + bytesCurrent
                        + " bytesTotal: " + bytesTotal + " " + percentDone + "%")
            }

            override fun onStateChanged(id: Int, state: TransferState?) {
                if (TransferState.COMPLETED == state) {
                    Log.d(TAG, "Upload state success")
                } else {
                    Log.d(TAG, "Upload state change: ${state?.name}")
                }
            }

            override fun onError(id: Int, ex: Exception?) {
                Log.e(TAG, "Error: ${ex.toString()}")
            }
        })
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
    }

    override fun onResume() {
        super.onResume()
        val newIntent = intent

        if (newIntent.data != null) {

            val email = newIntent.data.getQueryParameter("email")
            val confirmCode = newIntent.data.getQueryParameter("confirmationCode")
            val name = newIntent.data.getQueryParameter("name")
            val picture = newIntent.data.getQueryParameter("picture")

            Log.d("deepLink", "hello: $email")

            publishSubject.onNext(email)
        }
    }

    override fun onStop() {
        super.onStop()
        compositeDisposable.dispose()
    }

    private fun sayHello(): String {
        return "hello there!!"
    }

    private fun sayHello2(imageCount: Int): String {
        return "hello 2 image count : $imageCount"
    }

    private fun testOcr(image: File?): String {
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
