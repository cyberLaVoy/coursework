package com.example.sudokuai

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Paint
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.graphics.Point
import android.graphics.drawable.BitmapDrawable
import android.view.MotionEvent
import android.view.MotionEvent.ACTION_DOWN
import android.view.View
import android.view.Window
import android.view.WindowManager
import android.widget.ImageView
import kotlinx.android.synthetic.main.activity_play_puzzle.*

private const val EXTRA_PUZZLE_LAYOUT = "com.example.sudokuai.playpuzzleactivity.puzzlelayout"

fun Context.playPuzzleIntent(sudokuPuzzleLayout: String): Intent {
    return Intent(this, PlayPuzzleActivity::class.java).apply {
        putExtra(EXTRA_PUZZLE_LAYOUT, sudokuPuzzleLayout)
    }
}

class PlayPuzzleActivity : AppCompatActivity() {
    var mSelectedRow = -1
    var mSelectedCol = -1
    private val mSudokuPuzzle = SudokuPuzzle()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN)
        setContentView(R.layout.activity_play_puzzle)

        val layout = intent.getStringExtra(EXTRA_PUZZLE_LAYOUT)
        mSudokuPuzzle.setLayout(layout)

        val puzzleBitmap = Bitmap.createBitmap(getRoundedSideLength(), getRoundedSideLength(), Bitmap.Config.ARGB_8888)
        val puzzleCanvas = Canvas(puzzleBitmap)
        val puzzleImageView = sudoku_puzzle
        drawSudokuBoard(puzzleImageView, puzzleCanvas, puzzleBitmap)
        puzzleImageView.setOnTouchListener { v: View, m: MotionEvent ->
            if (m.actionMasked == ACTION_DOWN) {
                val row = (m.y/getCellSideLength()).toInt()
                val col = (m.x/getCellSideLength()).toInt()
                if (mSudokuPuzzle.isCellMutable(row, col)) {
                    mSelectedRow = row
                    mSelectedCol = col
                    reDrawSudokuBoardWithSelectedCell(puzzleImageView, puzzleCanvas, puzzleBitmap)
                }
            }
            true
        }

        val digitSelectionImageView = digit_selection
        val digitSelectionParams = getDigitSelectorDimensions()
        val digitSelectionBitmap = Bitmap.createBitmap(digitSelectionParams.first, digitSelectionParams.second, Bitmap.Config.ARGB_8888)
        val digitSelectionCanvas = Canvas(digitSelectionBitmap)
        drawDigitSelection(digitSelectionImageView, digitSelectionCanvas, digitSelectionBitmap)
        digitSelectionImageView.setOnTouchListener { v: View, m: MotionEvent ->
            if (m.actionMasked == ACTION_DOWN && !(mSelectedCol == -1 && mSelectedRow == -1)) { // do nothing if no cell is selected
                val dimensions = getDigitSelectorDimensions()
                val width = dimensions.first/5
                val height = dimensions.second/2
                var digitSelected = ( (m.x/width).toInt()+1 ) + 5*(m.y/height).toInt()
                if (digitSelected == 10) digitSelected = 0 // if delete selector was touched, null cell with 0
                val cellChanged = mSudokuPuzzle.setCell(mSelectedRow, mSelectedCol, digitSelected.toString())
                if (cellChanged) { // protects against unnecessary redrawing
                    drawSudokuBoard(puzzleImageView, puzzleCanvas, puzzleBitmap)
                    reDrawSudokuBoardWithSelectedCell(puzzleImageView, puzzleCanvas, puzzleBitmap)
                }
            }
            true
        }
    }
    private fun getSideLength(): Float {
        val display = windowManager.defaultDisplay
        val size = Point()
        display.getSize(size)
        return (size.x).toFloat()
    }
    private fun getRoundedSideLength(): Int{
        return Math.ceil(getSideLength().toDouble()).toInt()
    }
    private fun getCellSideLength(): Float {
        return getSideLength()/9
    }
    private fun getSelectorSideLength(): Float {
        val margin = 2*getCellSideLength()
        return (getSideLength()-margin)/5
    }
    private fun getDigitSelectorDimensions(): Pair<Int, Int> {
        val height = (getSelectorSideLength()*2).toInt()
        val width = (getSelectorSideLength()*5).toInt()
        return Pair(width, height)
    }
    private fun getSelectorRadius(): Float {
        val spacing = 7
        return getSelectorSideLength()/2-spacing
    }
    private fun drawDigit(canvas: Canvas, radius: Float, xc: Float, yc: Float, digit: String, isMutable: Boolean) {
        val paint = Paint()
        if (isMutable) {
            paint.color = resources.getColor(R.color.mutableDigit)
        }
        else {
            paint.color = resources.getColor(R.color.immutableDigit)
        }
        paint.textSize = radius*1.75f // manual adjustment
        paint.textAlign = Paint.Align.CENTER // horizontal align
        val newYc = yc - (paint.descent() + paint.ascent()) / 2 // vertical align
        canvas.drawText(digit, xc, newYc, paint)
    }
    private fun drawSudokuBoardDigits(canvas: Canvas) {
        val radius = getCellSideLength()/2
        for (row in 0..8) {
            for (col in 0..8) {
                val xc = getCellSideLength()*col+radius
                val yc = getCellSideLength()*row+radius
                val cellValue = mSudokuPuzzle.getCell(row, col)
                val isMutable = mSudokuPuzzle.isCellMutable(row, col)
                drawDigit(canvas, radius-3, xc, yc, cellValue, isMutable) // minus 3 radius to match size of highlighted version of cell
            }
        }
    }
    private fun reDrawSudokuBoardWithSelectedCell(puzzleImageView: ImageView, puzzleCanvas: Canvas, puzzleBitmap: Bitmap) {
        if (mSelectedCol == -1 && mSelectedRow == -1)
            return // to nothing if no cell has been selected
        val tempBitmap = puzzleBitmap.copy(Bitmap.Config.ARGB_8888, true)
        val tempCanvas = Canvas(tempBitmap)
        var radius = getCellSideLength()/2
        val xc = mSelectedCol*getCellSideLength()+radius
        val yc = mSelectedRow*getCellSideLength()+radius
        val paint = Paint()
        paint.color = resources.getColor(R.color.colorAccent)
        radius -= 3 // minus 3 from radius to not cover up puzzle lines
        tempCanvas.drawCircle(xc, yc, radius, paint)
        val cellValue = mSudokuPuzzle.getCell(mSelectedRow, mSelectedCol)
        drawDigit(tempCanvas,radius,xc,yc,cellValue, true)
        puzzleImageView.background = BitmapDrawable(resources, tempBitmap)
    }
    private fun drawSudokuBoard(sudokuPuzzle: ImageView, canvas: Canvas, bitmap: Bitmap) {
        sudokuPuzzle.layoutParams.height = getRoundedSideLength()
        sudokuPuzzle.layoutParams.width = getRoundedSideLength()
        val paint = Paint()
        paint.color = resources.getColor(R.color.colorPrimary)
        canvas.drawRect(0f,0f, getSideLength(), getSideLength(), paint)
        val cellSideLength: Float = getCellSideLength()
        val outerSideLength: Float = getSideLength()
        for (i in 1..8) {
            //minor lines
            paint.color = resources.getColor(R.color.colorAccent)
            paint.strokeWidth = 2f
            canvas.drawLine(0f, i*cellSideLength, outerSideLength, i*cellSideLength, paint)
            canvas.drawLine(i*cellSideLength, 0f, i*cellSideLength, outerSideLength, paint)
            //major lines
            if (i % 3 == 0) {
                paint.color = resources.getColor(R.color.colorPrimaryDark)
                paint.strokeWidth = 5f
                canvas.drawLine(0f, i*cellSideLength, outerSideLength, i*cellSideLength, paint)
                canvas.drawLine(i*cellSideLength, 0f, i*cellSideLength, outerSideLength, paint)

            }
        }
        drawSudokuBoardDigits(canvas)
        sudokuPuzzle.background = BitmapDrawable(resources, bitmap)
    }
    private fun drawDigitSelection(digitSelection: ImageView, canvas: Canvas, bitmap:Bitmap) {
        val dimensions = getDigitSelectorDimensions()
        digitSelection.layoutParams.width = dimensions.first
        digitSelection.layoutParams.height = dimensions.second
        val paint = Paint()
        paint.flags = Paint.ANTI_ALIAS_FLAG // make selector circles smooth
        val radius = getSelectorRadius()
        val selectorBorder = 3 // border size around each selector circle
        for (row in 0..1) {
            for (col in 0..4) {
                val xc = col*getSelectorSideLength() + radius
                val yc = row*getSelectorSideLength() + radius
                paint.color = resources.getColor(R.color.colorPrimaryDark)
                canvas.drawCircle(xc, yc, radius, paint)
                paint.color = resources.getColor(R.color.colorPrimary)
                canvas.drawCircle(xc, yc, radius-selectorBorder, paint)
                var digit: String = ( (col+1)+(row*5) ).toString() // calculate digit string
                if (digit == "10") digit = "X" // set digit to "X" for delete selector
                drawDigit(canvas, radius, xc, yc, digit, false)
            }
        }
        digitSelection.background = BitmapDrawable(resources, bitmap)
    }
}
