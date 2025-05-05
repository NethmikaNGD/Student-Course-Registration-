package com.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class fileRead {
    private String filePath;

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFilePath() {
        return filePath;
    }

    public boolean isValid(String wantToCheck) {
        try (BufferedReader br = new BufferedReader(new FileReader(getFilePath()))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] words = line.split("\t");
                for (String word : words) {
                    if (word.equals(wantToCheck)) {
                        return true;
                    }
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file (util/FileRead): " + e.getMessage());
        }
        return false;
    }
}


