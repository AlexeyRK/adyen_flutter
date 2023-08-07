package app.adyen.flutter_adyen_example

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import app.adyen.flutter_adyen.FlutterAdyenPlugin
import kotlin.concurrent.thread


class ResultActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val dataString: String? = intent.dataString

        if (dataString != null ) {

            thread(start = true, priority = -1) {
                FlutterAdyenPlugin.processRedirectData(intent, this)
                runOnUiThread {
                    val intentMain = Intent(this, MainActivity::class.java)
                    intentMain.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    intentMain.data = intent.data
                    startActivity(intentMain)
                }
            }

//            val sharedPref = getSharedPreferences("ADYEN", Context.MODE_PRIVATE)
//            with(sharedPref.edit()) {
//                remove("AdyenResultCode")
//                putString("AdyenResultCode", "SUCCESSSSSS")
//                commit()
//            }






        } else {
            onBackPressed()
        }


    }
}