package fr.ganfra.realm;

import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;

/* DO NOT EDIT | Generated by gyro */

public class Product extends RealmObject {

    public interface Attributes {
        String BRAND = "brand";
        String NAME = "name";
        String PRICE = "price";
    }

    private String brand;
    @PrimaryKey
    private String name;
    private int price;

    public String getBrand() {
        return brand;
    }

    public void setBrand(final String brand) {
        this.brand = brand;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(final int price) {
        this.price = price;
    }
}
