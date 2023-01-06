package com.example.sudokuai

import android.content.Intent
import android.net.Uri
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.view.View
import kotlinx.android.synthetic.main.activity_main.*
import android.support.v4.content.FileProvider
import android.view.MotionEvent
import android.view.Window
import android.view.WindowManager
import java.io.File
import java.io.IOException
import java.util.*
import java.text.DateFormat.getDateTimeInstance


var currentPhotoPath: String = ""

class MainActivity : AppCompatActivity() {
    val REQUEST_IMAGE_CAPTURE = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN)
        setContentView(R.layout.activity_loading)
        setContentView(R.layout.activity_main)

        val btnCameraButton = camera_button // refers to xml id directly
        val loadingIcon = camera_loading_icon
        btnCameraButton.setOnTouchListener { v: View, m: MotionEvent ->
            if (m.actionMasked == MotionEvent.ACTION_DOWN) {
                loadingIcon.visibility = View.VISIBLE
                btnCameraButton.background = resources.getDrawable(R.drawable.red_eye_camera)
            }
            if (m.actionMasked == MotionEvent.ACTION_UP) {
                dispatchTakePictureIntent()
            }
            true
        }
    }

    @Throws(IOException::class)
    private fun createImageFile(): File {
        val timeStamp = getDateTimeInstance().format(Date())
        val storageDir = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        return File.createTempFile("JPEG_${timeStamp}_", ".jpg", storageDir
        ).apply {
            currentPhotoPath = absolutePath
        }
    }
    private fun dispatchTakePictureIntent() {
        Intent(MediaStore.ACTION_IMAGE_CAPTURE).also { takePictureIntent ->
            takePictureIntent.resolveActivity(packageManager)?.also {
                val photoFile: File? = try {
                    createImageFile()
                } catch (ex: IOException) {
                    null
                }
                photoFile?.also {
                    val photoURI: Uri = FileProvider.getUriForFile(this, "com.example.android.fileprovider", it)
                    takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
                    startActivityForResult(takePictureIntent, REQUEST_IMAGE_CAPTURE)
                }
            }
        }
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        val btnCameraButton = camera_button // refers to xml id directly
        val loadingIcon = camera_loading_icon
        loadingIcon.visibility = View.INVISIBLE
        btnCameraButton.background = resources.getDrawable(R.drawable.eye_camera)
        if (requestCode == REQUEST_IMAGE_CAPTURE && resultCode == RESULT_OK && resultCode != RESULT_CANCELED) {
            startActivity(loadingActivityIntent(currentPhotoPath))
        }
    }

}
