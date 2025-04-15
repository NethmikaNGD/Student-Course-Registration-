package com.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class getTime {
    public String getTime() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = formatter.format(new Date());
        return dateTime;


    }
}
