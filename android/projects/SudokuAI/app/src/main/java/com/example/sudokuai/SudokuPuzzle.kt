package com.example.sudokuai

class SudokuPuzzle {
    private var mLayout: String = ""
    private var mImmutable = BooleanArray(81)

    private fun cellIndex(row: Int, col: Int): Int {
        return 9*row+col
    }
    fun isCellMutable(row: Int, col: Int): Boolean {
        return ! mImmutable[cellIndex(row, col)]
    }
    private fun setCellAsImmutable(layoutIndex: Int) {
        mImmutable[layoutIndex] = true
    }
    fun setLayout(layout: String) {
        for (i in 0..(layout.length-1)) {
           if (layout[i] != '0') {
                setCellAsImmutable(i)
           }
        }
        mLayout = layout
    }
    fun setCell(row: Int, col: Int, cellValue: String): Boolean {
        val cellIndex = cellIndex(row, col)
        if (getCell(row, col) == cellValue) return false // if no legitimate change is made, return false
        mLayout = mLayout.substring(0,cellIndex) + cellValue + mLayout.substring(cellIndex+1,mLayout.length)
        return true
    }
    fun getCell(row: Int, col:Int): String {
        val cellValue = mLayout[cellIndex(row, col)].toString()
        if (cellValue == "0") {
            return ""
        }
        return cellValue
    }
}