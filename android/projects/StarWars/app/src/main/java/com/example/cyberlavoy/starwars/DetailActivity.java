package com.example.cyberlavoy.starwars;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class DetailActivity extends AppCompatActivity {

    String mCharacterName;
    String mCharacterHairColor;
    String mCharacterSkinColor;
    String mCharacterEyeColor;

    TextView mCharacterNameTextView;
    TextView mCharacterHairColorTextView;
    TextView mCharacterSkinColorTextView;
    TextView mCharacterEyeColorTextView;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        mCharacterNameTextView = findViewById(R.id.details_name);
        mCharacterHairColorTextView = findViewById(R.id.details_hair);
        mCharacterSkinColorTextView = findViewById(R.id.details_skin);
        mCharacterEyeColorTextView = findViewById(R.id.details_eyes);


        mCharacterName = getIntent().getStringExtra("character_name");
        mCharacterHairColor = getIntent().getStringExtra("hair_color");
        mCharacterSkinColor = getIntent().getStringExtra("skin_color");
        mCharacterEyeColor = getIntent().getStringExtra("eye_color");

        mCharacterNameTextView.setText(mCharacterName);
        mCharacterHairColorTextView.setText(mCharacterHairColor);
        mCharacterSkinColorTextView.setText(mCharacterSkinColor);
        mCharacterEyeColorTextView.setText(mCharacterEyeColor);

    }
}
