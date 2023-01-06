package com.example.cyberlavoy.starwars;

import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by CyberLaVoy on 5/2/2018.
 */

public class CharacterFetcher {
    private static final String TAG = "CharacterFetcher";

    public byte[] getUrlBytes(String urlSpec) throws IOException {
        URL url = new URL(urlSpec);
        HttpURLConnection connection = (HttpURLConnection)url.openConnection();

        try {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            InputStream in = connection.getInputStream();

            if (connection.getResponseCode() != HttpURLConnection.HTTP_OK) {
                throw new IOException(connection.getResponseMessage() +
                        ": with " +
                        urlSpec);
            }

            int bytesRead = 0;
            byte[] buffer = new byte[1024];
            while ((bytesRead = in.read(buffer)) > 0) {
                out.write(buffer, 0, bytesRead);
            }
            out.close();
            return out.toByteArray();
        } finally {
            connection.disconnect();
        }
    }

    public String getUrlString(String urlSpec) throws IOException {
        return new String(getUrlBytes(urlSpec));
    }

    public List<Character> fetchItems() {
        List<Character> items = new ArrayList<>();
        try {
            String url = "https://swapi.co/api/people/?format=json";
            String jsonString = getUrlString(url);
            Log.i(TAG, "Received JSON: " + jsonString);
            JSONObject jsonBody = new JSONObject(jsonString);
            parseItems(items, jsonBody);
        } catch (IOException ioe) {
            Log.e(TAG, "Failed to fetch items", ioe);
        } catch (JSONException je){
            Log.e(TAG, "Failed to parse JSON", je);
        }
        return items;
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
