package com.example.cyberlavoy.criminalintent;

import android.support.v4.app.Fragment;

/**
 * Created by CyberLaVoy on 2/9/2018.
 */

public class CrimeListActivity extends SingleFragmentActivity {
    @Override
    protected Fragment createFragment() {
        return new CrimeListFragment();
    }
}
