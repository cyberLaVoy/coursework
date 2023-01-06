package com.example.sudokuai

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import java.io.File
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL
import java.util.*

class PuzzleLoader {
    val API_URL = "http://sudoku-ai-rest-api.herokuapp.com/puzzles"

    fun wakeUpServer() {
        val connection = URL(API_URL).openConnection() as HttpURLConnection
        try {
            val data = connection.inputStream.bufferedReader().readText()
            println(data)
        } finally {
            connection.disconnect()
        }
    }
    fun loadPuzzle(imagePath: String): String {
        val image: Bitmap = BitmapFactory.decodeFile(imagePath)
        try {
            val url = URL(API_URL)
            val c = url.openConnection() as HttpURLConnection
            c.doInput = true
            c.requestMethod = "POST"
            c.doOutput = true
            c.connect()
            val output = c.outputStream
            val quality = 80 // represents a percentage
            image.compress(Bitmap.CompressFormat.JPEG, quality, output)
            output.close()
            val result = Scanner(c.inputStream)
            val response = result.nextLine()
            result.close()
            // delete file after use
            val fdelete = File(currentPhotoPath)
            fdelete.delete()
            return response
        } catch (e: IOException) {
            Log.e("ImageUploader", "Error uploading image", e)
            return ""
        }
    }
}