package kr.co.lecle.flutter_app_demo

import io.flutter.app.FlutterApplication
import com.instabug.instabugflutter.InstabugFlutterPlugin



class Application : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        val invocationEvents: ArrayList<String> = arrayListOf()

        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE)
        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_FLOATING_BUTTON)

        InstabugFlutterPlugin().start(this, "APP_TOKEN", invocationEvents)
    }
}