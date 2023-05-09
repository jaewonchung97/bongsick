package com.bongsick.bongsick.domain;

import lombok.Data;

import java.util.List;

@Data
public class Theme {
    String id;
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
