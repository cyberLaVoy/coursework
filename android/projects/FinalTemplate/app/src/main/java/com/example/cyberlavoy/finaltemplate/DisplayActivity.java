package com.example.cyberlavoy.finaltemplate;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

public class DisplayActivity extends AppCompatActivity {

    TextView mFavoriteNumberTextView;
    String mFavoriteNumber;
    RecyclerView mFavoriteNumbersRecylerView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display);
        mFavoriteNumberTextView = findViewById(R.id.favorite_number_display);

        mFavoriteNumber = getIntent().getStringExtra("favorite_number");
        mFavoriteNumberTextView.setText(mFavoriteNumber);

        mFavoriteNumbersRecylerView = findViewById(R.id.favorite_number_list);
        mFavoriteNumbersRecylerView.setLayoutManager(new LinearLayoutManager(DisplayActivity.this));
        List<String> favoriteNumbers = FavoriteNumberStore.getInstance().getFavoriteNumbers();
        mFavoriteNumbersRecylerView.setAdapter(new FavoriteNumberAdapter(favoriteNumbers));
    }

    private class FavoriteNumberAdapter extends RecyclerView.Adapter<FavoriteNumberHolder> {
        List<String>  mFavoriteNumbers;
        public FavoriteNumberAdapter(List<String> favoriteNumbers) {
            mFavoriteNumbers = favoriteNumbers;
        }
        @Override
        public FavoriteNumberHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View itemView = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.favorite_number_item, parent, false);
            return new FavoriteNumberHolder(itemView);
        }

        @Override
        public void onBindViewHolder(FavoriteNumberHolder holder, int position) {
            holder.bind(mFavoriteNumbers.get(position));
        }

        @Override
        public int getItemCount() {
            return mFavoriteNumbers.size();
        }
    }
    private class FavoriteNumberHolder extends RecyclerView.ViewHolder {
        TextView mFavoriteNumberTextView;

        public FavoriteNumberHolder(View itemView) {
            super(itemView);
            mFavoriteNumberTextView = itemView.findViewById(R.id.favorite_number);
        }
        public void bind(String favoriteNumber) {
            mFavoriteNumberTextView.setText(favoriteNumber);
        }
    }
}
