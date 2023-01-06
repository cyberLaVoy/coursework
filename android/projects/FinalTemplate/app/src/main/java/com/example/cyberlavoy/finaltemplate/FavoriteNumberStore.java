package com.example.cyberlavoy.finaltemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by CyberLaVoy on 4/26/2018.
 */

public class FavoriteNumberStore {
    private static final FavoriteNumberStore ourInstance = new FavoriteNumberStore();
    List<String> mFavoriteNumbers;

    public static FavoriteNumberStore getInstance() {
        return ourInstance;
    }

    private FavoriteNumberStore() {
        mFavoriteNumbers = new ArrayList<>();
        for (int i = 27; i < 101; i+=2) {
            mFavoriteNumbers.add(Integer.toString(i));
        }
    }
    public List<String> getFavoriteNumbers() {
        return mFavoriteNumbers;
    }
    public void addFavoriteNumber(String favoriteNumber) {
        mFavoriteNumbers.add(favoriteNumber);
    }

}
