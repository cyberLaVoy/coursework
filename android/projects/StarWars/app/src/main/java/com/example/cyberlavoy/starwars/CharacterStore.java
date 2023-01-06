package com.example.cyberlavoy.starwars;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by CyberLaVoy on 5/2/2018.
 */

public class CharacterStore {
    private List<Character> mCharacterList;
    private static final CharacterStore ourInstance = new CharacterStore();

    public static CharacterStore getInstance() {
        return ourInstance;
    }

    private CharacterStore() {
        mCharacterList = new ArrayList<>();
    }

    public List<Character> getCharacters() {
        return mCharacterList;
    }
    public void addCharacter(Character character) {
        mCharacterList.add(character);
    }
}
