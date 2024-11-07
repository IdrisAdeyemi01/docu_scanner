package com.example.docu_scanner

import android.content.Intent
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.FileProvider
import java.io.File


private const val CHANNEL = "documentScannerPlatform"

class MainActivity : FlutterFragmentActivity(){
    private lateinit var methodChannelResult: MethodChannel.Result

    private val options =
        GmsDocumentScannerOptions.Builder()
            .setPageLimit(1)
            .setScannerMode(GmsDocumentScannerOptions.SCANNER_MODE_FULL)
            .setResultFormats(GmsDocumentScannerOptions.RESULT_FORMAT_PDF, GmsDocumentScannerOptions.RESULT_FORMAT_JPEG)
            .build()


    private val scanner = GmsDocumentScanning.getClient(options)

    private val scannerLauncher =
        registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()){ result ->

            val resultCode = result.resultCode
            if (resultCode == RESULT_OK){
                val docResult = GmsDocumentScanningResult.fromActivityResultIntent(result.data)
                val imagePages = docResult?.pages
                if (!imagePages.isNullOrEmpty()){
                    val imageUrl = imagePages[0].imageUri
                    methodChannelResult.success("$imageUrl")
                }

                docResult?.pdf?.uri?.path?.let { path ->
                    val externalUri = FileProvider.getUriForFile(this, "$packageName.provider", File(path))
                    val shareIntent =
                        Intent(Intent.ACTION_SEND).apply {
                            putExtra(Intent.EXTRA_STREAM, externalUri)
                            type = "application/pdf"
                            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        }
                    startActivity(Intent.createChooser(shareIntent, "Share PDF"))
                }
            }else{
                methodChannelResult.error("Error", "Document Scanning Failed", "None")
            }
        }

//    private fun sharePdf(filePath: String){
//        val externalUri = FileProvider.getUriForFile(this, "$packageName.provider", File(filePath))
//        val shareIntent =
//            Intent(Intent.ACTION_SEND).apply {
//                putExtra(Intent.EXTRA_STREAM, externalUri)
//                type = "application/pdf"
//                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
//            }
//        startActivity(Intent.createChooser(shareIntent, "Share PDF"))
//    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.platformViewsController
            .registry
            .registerViewFactory("myImageView", ImageViewFactory())

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            methodChannelResult = result
            when(call.method){
                "scan" -> {
                    scanner.getStartScanIntent(this)
                        .addOnSuccessListener {
                            intentSender -> scannerLauncher.launch(IntentSenderRequest.Builder(intentSender).build())
                    }
                        .addOnFailureListener{
                            Toast.makeText(this, "Unable to complete scanning successfully", Toast.LENGTH_LONG).show()
                        }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        super.configureFlutterEngine(flutterEngine)
    }


}
