package com.flutter.payclip

import androidx.annotation.NonNull

import java.math.BigDecimal
import android.app.Activity
import android.app.Application
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

//! IMPORT CLIP LIBS
import com.payclip.common.StatusCode
import com.payclip.dspread.ClipPlusApi
import com.payclip.paymentui.client.ClipApi
import com.payclip.paymentui.models.ClipPayment
import com.payclip.payments.models.transaction.ClipTransaction

/** FlutterPayclipPlugin */
class FlutterPayclipPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  val REQUEST_CODE_PAYMENT = 42490
  val REQUEST_CODE_SETTINGS = 42491

  private lateinit var application: Application
  private lateinit var activity: Activity
  private lateinit var channel: MethodChannel
  private lateinit var result: Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    application = flutterPluginBinding.getApplicationContext() as Application
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_payclip")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull r: Result) {
    this.result = r

    when(call.method){
      "init" -> {
        ClipApi.init(application, ClipPlusApi())
        r.success(true)
      }
      "settings" -> {
        ClipApi.showSettingsActivity(
          activity, 
          loginEnabled = arguments["loginEnabled"] as Boolean, 
          logoutEnabled = arguments["logoutEnabled"] as Boolean, 
          requestCode = REQUEST_CODE_SETTINGS
        )
      }
      "payment" -> {
        val arguments = call.arguments as HashMap<*, *>
        val clipPayment = ClipPayment.Builder()
          .amount(BigDecimal(arguments["amount"] as Double))
          .enableContactless(arguments["enableContactless"] as Boolean)
          .enableTips(arguments["enableTips"] as Boolean)
          .roundTips(arguments["roundTips"] as Boolean)
          .enablePayWithPoints(arguments["enablePayWithPoints"] as Boolean)
          .customTransactionId(arguments["customTransactionId"] as String)
          .build()
        ClipApi.launchPaymentActivity(
          activity,
          clipPayment,
          REQUEST_CODE_PAYMENT
        )
      }
      else -> r.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    //activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    //activity = null
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    when(requestCode){
      REQUEST_CODE_PAYMENT -> {
        this.result.success("CODE: ${data?.getIntExtra(StatusCode.RESULT_CODE, StatusCode.FAILURE)} ${resultCode}")
        return true
      }
      REQUEST_CODE_SETTINGS -> {
        if(resultCode == -1){
          this.result.success(true)
          return true
        }
        this.result.success(false)
        return false
      }
      else -> {
        return false
      }
    }
  }
}
