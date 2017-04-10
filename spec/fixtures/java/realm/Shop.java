package fr.ganfra.realm;

import io.realm.RealmList;
import io.realm.RealmObject;

/* DO NOT EDIT | Generated by gyro */

public class Shop extends RealmObject {

    public interface Attributes {
        String NAME = "name";
    }

    public interface Relationships {
        String PRODUCTS = "products";
    }

    private String name;
    private RealmList<Product> products;

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public RealmList<Product> getProducts() {
        return products;
    }

    public void setProducts(final RealmList<Product> products) {
        this.products = products;
    }
}
