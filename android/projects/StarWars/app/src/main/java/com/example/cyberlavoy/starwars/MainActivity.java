package com.example.cyberlavoy.starwars;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "MainActivity";
    List<Character> mItems = new ArrayList<>();
    RecyclerView mCharactersRecyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getCharacters();
        //new FetchItemsTask().execute();

        mCharactersRecyclerView = findViewById(R.id.character_recycler_view);
        mCharactersRecyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));
        setupAdapter();
    }

    private class CharacterHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        Character mCharacter;
        TextView mCharacterNameTextView;
        TextView mCharacterBirthYearTextView;
        TextView mCharacterGenderTextView;

        public CharacterHolder(@NonNull View itemView) {
            super(itemView);
            mCharacterNameTextView = itemView.findViewById(R.id.character_name);
            mCharacterBirthYearTextView = itemView.findViewById(R.id.birth_year);
            mCharacterGenderTextView = itemView.findViewById(R.id.gender);
            itemView.setOnClickListener(this);
        }

        public void bind(Character character) {
            mCharacter = character;
            mCharacterNameTextView.setText(character.getName());
            mCharacterBirthYearTextView.setText(character.getBirthYear());
            mCharacterGenderTextView.setText(character.getGender());
        }

        @Override
        public void onClick(View view) {
            Intent intent = new Intent(MainActivity.this, DetailActivity.class);
            intent.putExtra("character_name", mCharacter.getName());
            intent.putExtra("hair_color", mCharacter.getHairColor());
            intent.putExtra("skin_color", mCharacter.getSkinColor());
            intent.putExtra("eye_color", mCharacter.getEyeColor());
            startActivity(intent);
        }
    }

    private void setupAdapter() {
        mCharactersRecyclerView.setAdapter(new CharactersAdapter(mItems));
    }

    private class CharactersAdapter extends RecyclerView.Adapter<CharacterHolder> {
        List<Character> mCharacters;
        private CharactersAdapter(List<Character> characters) {
            mCharacters = characters;
        }
        @NonNull
        @Override
        public CharacterHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View itemView = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.list_item_character, parent, false);
            return new CharacterHolder(itemView);
        }

        @Override
        public void onBindViewHolder(@NonNull CharacterHolder holder, int position) {
            holder.bind(mCharacters.get(position));
        }

        @Override
        public int getItemCount() {
            return mCharacters.size();
        }
    }

    private class FetchItemsTask extends AsyncTask< Void,Void,List<Character> > {
        @Override
        protected List<Character> doInBackground(Void... params) {
            return new CharacterFetcher().fetchItems();
        }
        @Override
        protected void onPostExecute(List<Character> items) {
            mItems = items;
            setupAdapter();
        }
    }

    // GET methods
    public void getCharacters() {
        String url = "https://swapi.co/api/people/?format=json";
        final List<Character> items = new ArrayList<>();
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest
                (Request.Method.GET, url, null, new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            String url = "https://swapi.co/api/people/?format=json";
                            parseItems(items, response);
                            mItems = items;
                            setupAdapter();
                        } catch (IOException ioe) {
                            Log.e(TAG, "Failed to fetch items", ioe);
                        } catch (JSONException je){
                            Log.e(TAG, "Failed to parse JSON", je);
                        }
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Log.e(TAG, "Volley error", error);
                    }
                });
        RequestHandler.getInstance(getApplicationContext()).addToRequestQueue(jsonObjectRequest);
    }
    private void parseItems(List<Character> items, JSONObject jsonBody)
            throws IOException, JSONException {

        JSONArray resultsJsonArray = jsonBody.getJSONArray("results");
        for (int i = 0; i < resultsJsonArray.length(); i++) {
            JSONObject characterJsonObject = resultsJsonArray.getJSONObject(i);

            Character item = new Character();
            item.setName(characterJsonObject.getString("name"));
            item.setHeight(characterJsonObject.getString("height"));
            item.setMass(characterJsonObject.getString("mass"));
            item.setHairColor(characterJsonObject.getString("hair_color"));
            item.setSkinColor(characterJsonObject.getString("skin_color"));
            item.setEyeColor(characterJsonObject.getString("eye_color"));
            item.setBirthYear(characterJsonObject.getString("birth_year"));
            item.setGender(characterJsonObject.getString("gender"));
            items.add(item);
        }
    }
}
