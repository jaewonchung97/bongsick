package com.bongsick.bongsick.domain;

import lombok.Data;

import java.util.List;

@Data
public class ThemeSave {
    String name;
    List<String> companies;
    int difficulty;
    String imgUrl;
    int personnelMax;
    int personnelMin;
    int playTime;
    String story;
    String genre;
    String reservationUrl;
}
