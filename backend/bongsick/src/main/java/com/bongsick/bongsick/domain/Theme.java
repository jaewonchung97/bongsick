package com.bongsick.bongsick.domain;

import lombok.Data;

@Data
public class Theme {
    String id;
    String name;
    String companyId;
    int difficulty;
    String imgUrl;
    int personnel_max;
    int personnel_min;
    int playTime;
    String story;
}
