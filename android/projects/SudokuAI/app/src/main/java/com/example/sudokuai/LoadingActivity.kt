package com.example.sudokuai

import android.content.Context
import android.content.Intent
import android.os.AsyncTask
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.Window
import android.view.WindowManager

private const val EXTRA_PUZZLE_PICTURE_PATH = "com.example.sudokuai.playpuzzleactivity.puzzlelayout"

fun Context.loadingActivityIntent(puzzlePicturePath: String): Intent {
    return Intent(this, LoadingActivity::class.java).apply {
        putExtra(EXTRA_PUZZLE_PICTURE_PATH, puzzlePicturePath)
    }
}

class LoadingActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN)
        setContentView(R.layout.activity_loading)
        val puzzlePicturePath = intent.getStringExtra(EXTRA_PUZZLE_PICTURE_PATH)
        processPictureAndLoadPuzzle().execute(puzzlePicturePath)
    }
    inner class processPictureAndLoadPuzzle() : AsyncTask<String, Void, String>() {
        override fun doInBackground(vararg params: String): String {
            val puzzleLoader = PuzzleLoader()
            val puzzlePicturePath = params[0]
            return puzzleLoader.loadPuzzle(puzzlePicturePath) // return layout of puzzle
        }
        override fun onPostExecute(result: String) {
            super.onPostExecute(result)
            startActivity(playPuzzleIntent(result))
            finish()
        }
    }
}
