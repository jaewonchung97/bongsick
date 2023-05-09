package com.bongsick.bongsick.domain;

import com.google.cloud.firestore.GeoPoint;
import lombok.Data;

@Data
public class CompanySave {
    String name;
    GeoPoint location;
    String address;
}
