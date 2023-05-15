package com.bongsick.bongsick.domain;

import com.google.cloud.firestore.GeoPoint;
import lombok.Data;

@Data
public class CompanySave {
    String name;
    GeoPoint location;
    String address;
    String phone;

    public CompanySave(Company company){
        this.name = company.getName();
        this.location = company.getLocation();
        this.address = company.getAddress();
        this.phone = company.getPhone();
    }
}
