package com.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class fileReading {
    private String fileName;
    private List<String> stData = new ArrayList<>();
    private List<String> inData = new ArrayList<>();

    public fileReading(String fileName) {
        this.fileName = fileName;
    }

    public void readFile() {
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length > 7 && data[7].equals("Student")) {
                    stData.add(line);
                } else {
                    inData.add(line);
                }
            }
        } catch (IOException e) {
            System.out.println("Error while reading file:");
            e.printStackTrace();
        }
    }

    public List<String> getStData() {
        return stData;
    }

    public List<String> getInData() {
        return inData;
    }
}
