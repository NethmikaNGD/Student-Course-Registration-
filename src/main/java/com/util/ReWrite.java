package com.util;

import java.io.*;
import java.util.*;

public class ReWrite {
    private String newPass;
    private String username;
    private final String mainUserDataFile = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    private final String userNamePassFile = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";

    public ReWrite(String newPass, String username) {
        this.newPass = newPass;
        this.username = username;
    }

    // Update password in userPass.txt
    public void updatePassword() {
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader br = new BufferedReader(new FileReader(userNamePassFile))) {
            String line;

            while ((line = br.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length >= 5) {
                    System.out.println("Comparing file username: [" + data[1] + "] with input username: [" + username + "]");
                }
                if (data.length >= 5 && data[1].equals(username) && !updated) {
                    // "Replace" this line by modifying it
                    line = data[0] + "\t" + username + "\t" + data[2] + "\t" + newPass + "\t" + data[4];
                    updated = true;
                }
                lines.add(line); // always add (modified or original)
            }
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        if (!updated) {
            System.out.println("Username not found. No changes made.");
            return;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(userNamePassFile))) {
            for (String l : lines) {
                bw.write(l);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Password updated successfully for user: " + username);
    }
    // Read userInfor.txt and sort userIds using Insertion Sort
    public void sortUserIds() {
        List<Integer> userIds = new ArrayList<>();
        boolean status;

        try (BufferedReader br = new BufferedReader(new FileReader(mainUserDataFile))) {
            String line;

            while ((line = br.readLine()) != null) {
                String[] data = line.split("\t");
                try {
                    userIds.add(Integer.parseInt(data[0]));
                    System.out.println("update");


                } catch (NumberFormatException ignored) {}
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Insertion Sort
        for (int i = 1; i < userIds.size(); i++) {
            int key = userIds.get(i);
            int j = i - 1;
            while (j >= 0 && userIds.get(j) > key) {
                userIds.set(j + 1, userIds.get(j));
                j--;
            }
            userIds.set(j + 1, key);
        }
        System.out.println("Sorted User IDs: " + userIds);


    }
}
