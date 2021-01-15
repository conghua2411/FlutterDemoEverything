package kr.co.lecle.flutter_app_demo


import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.Environment.*
import android.util.Log
import androidx.core.app.NotificationCompat
import com.amazonaws.mobile.client.AWSMobileClient
import com.amazonaws.mobile.client.Callback
import com.amazonaws.mobile.client.UserState
import com.amazonaws.mobile.client.UserStateDetails
import com.amazonaws.mobile.client.results.SignInResult
import com.amazonaws.mobileconnectors.s3.transferutility.*
import com.amazonaws.services.s3.AmazonS3Client
import com.googlecode.tesseract.android.TessBaseAPI
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.subjects.PublishSubject
import java.io.File

class MainActivity : FlutterActivity() {

    val TAG = "MainActivity"

    lateinit var ocrApi: TessBaseAPI

    val compositeDisposable = CompositeDisposable()

    val publishSubject = PublishSubject.create<String>()

    // deep link native
    private val deepLinkChannel = "poc.deeplink.flutter.dev/cnannel";

    var startString: String? = null

    private val EVENTS = "poc.deeplink.flutter.dev/events"

    var linksReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val channel = "com.example.flutter_app/main"
        val STREAM = "com.example.flutter_app/main"

        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deepLinkChannel).setMethodCallHandler { call, result ->
            Log.d("asd", "asdasdasd")
        }
        // deep link native
        val intent: Intent = intent

        val data: Uri? = intent.data

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deepLinkChannel).setMethodCallHandler(object : MethodChannel.MethodCallHandler {
            override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                if (call.method == "initialLink") {
                    result.success(startString)
                } else {
                    result.success("startString is null")
                }
            }
        })

        if (data != null) {
            startString = data.toString()
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENTS).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                Log.d("DeepLink", "setup onListen")
                if (linksReceiver == null) {
                    linksReceiver = createChangeReceiver(events)
                }
            }

            override fun onCancel(arguments: Any?) {
                Log.d("DeepLink", "setup onCancel")
                linksReceiver = null
            }
        })

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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
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
                        File("${getExternalStorageDirectory().path}/Pictures/1536807835610.jpg")
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

        Log.d("onNewIntent", "onNewIntent begin")

        if (intent.data != null) {
            Log.d("onNewIntent", "${intent.data}")
        } else {
            Log.d("onNewIntent", "null")
        }

        setIntent(intent)

        if (intent.action == Intent.ACTION_VIEW && linksReceiver != null) {
            linksReceiver?.onReceive(this.applicationContext, intent)
        }
    }

    fun createChangeReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {

                Log.d("DeepLink", "createChangeReceiver: onReceive ${intent.data} -- ${intent.dataString}")

                // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW

                val dataString = intent.dataString

                if (dataString == null) {
                    events?.error("UNAVAILABLE", "Link unavailable", null)
                } else {
                    events?.success(dataString)
                }
            }
        }
    }

    override fun onResume() {
        super.onResume()
        val newIntent = intent

        if (newIntent.data != null) {

//            val email = newIntent.data.getQueryParameter("email")
//            val confirmCode = newIntent.data.getQueryParameter("confirmationCode")
//            val name = newIntent.data.getQueryParameter("name")
//            val picture = newIntent.data.getQueryParameter("picture")

            Log.d("deepLink", "hello: ${newIntent.data}")

            // test deep link 2
            if (newIntent.action == Intent.ACTION_VIEW && linksReceiver != null) {
                linksReceiver?.onReceive(this.applicationContext, newIntent)
            }

//            publishSubject.onNext(email)
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
