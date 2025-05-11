package com.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CourseFileReading {
    private String fileName;

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }
    private List<String> enrollList = new ArrayList<>();
    private List<String> CourseList = new ArrayList<>();

    public void readFile() {
        try (BufferedReader br = new BufferedReader(new FileReader(getFileName()))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split("\t");
                CourseList.add(line);

            }
        } catch (IOException e) {
            System.out.println("Error while reading file:");
            e.printStackTrace();
        }
    }

    public List<String> getCouseList() {
        return CourseList;
    }


}
