package org.example;

import java.text.SimpleDateFormat;
import java.util.Date;

public class time {
    public String myTime(){
    Long currentTime = System.currentTimeMillis();
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("hh:mm:ss");
    Date date = new Date(currentTime);
    String time = simpleDateFormat.format(date);
    return time;
    }
}
