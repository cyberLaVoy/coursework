package com.example.sudokuai

import android.content.Intent
import android.os.AsyncTask
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.Window
import android.view.WindowManager

class SplashScreenActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN)
        setContentView(R.layout.activity_splash_screen)
        wakeUpServerAndStartMainActivity().execute()
    }
    inner class wakeUpServerAndStartMainActivity() : AsyncTask<Void, Void, String>() {
        override fun doInBackground(vararg params: Void?): String? {
            val puzzleLoader = PuzzleLoader()
            puzzleLoader.wakeUpServer()
            return ""
        }
        override fun onPostExecute(result: String?) {
            super.onPostExecute(result)
            val activity = Intent(this@SplashScreenActivity, MainActivity::class.java)
            startActivity(activity)
            finish()
        }
    }
}
