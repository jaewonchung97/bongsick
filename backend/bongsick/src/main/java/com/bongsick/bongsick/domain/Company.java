package com.bongsick.bongsick.domain;

import com.google.cloud.firestore.GeoPoint;
import lombok.Data;

import java.util.Map;

@Data
public class Company {
    String id;
    String name;
    GeoPoint location;
}
