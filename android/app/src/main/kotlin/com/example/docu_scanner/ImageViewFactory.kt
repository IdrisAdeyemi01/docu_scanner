package com.example.docu_scanner

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


 class ImageViewFactory:  PlatformViewFactory(StandardMessageCodec.INSTANCE){
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView{
        val creationParams = args as Map<String?, Any?>?
        return AppImageView(context, viewId, creationParams)
    }
}