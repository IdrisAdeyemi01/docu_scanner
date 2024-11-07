package com.example.docu_scanner

import android.content.Context
import android.view.View
import android.widget.ImageView
import com.bumptech.glide.Glide
import io.flutter.plugin.platform.PlatformView


class AppImageView(context: Context, id: Int, creationParams: Map<String?, Any?>?): PlatformView {
    private val imageView: ImageView

    override fun getView(): View {
        return imageView
    }

    override fun dispose(){}
    init {
        imageView = ImageView(context)
        Glide.with(imageView).load(creationParams?.get("text")?.toString()).into(imageView)
    }
}