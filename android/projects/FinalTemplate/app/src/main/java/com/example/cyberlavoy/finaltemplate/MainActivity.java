package com.example.cyberlavoy.finaltemplate;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    EditText mNumberEntryEditText;
    Button mGoButton;
    Button mToastButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mNumberEntryEditText = findViewById(R.id.number_entry);
        mGoButton = findViewById(R.id.go_button);
        mToastButton = findViewById(R.id.toast_button);

        mGoButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
               String favoriteNumber = mNumberEntryEditText.getText().toString();
               FavoriteNumberStore.getInstance().addFavoriteNumber(favoriteNumber);

               Intent intent = new Intent(MainActivity.this, DisplayActivity.class);
               intent.putExtra("favorite_number", favoriteNumber);
               startActivity(intent);
            }
        });


        mToastButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast cheers = new Toast(MainActivity.this);
                cheers.makeText(MainActivity.this, "Cheers!", Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.activity_main, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.idea_icon:
                Toast idea = new Toast(MainActivity.this);
                idea.makeText(MainActivity.this, "Ding!", Toast.LENGTH_SHORT).show();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
