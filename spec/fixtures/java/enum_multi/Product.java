package fr.ganfra.realm;

import io.realm.RealmObject;
import io.realm.annotations.Ignore;

/* DO NOT EDIT | Generated by gyro */

public class Product extends RealmObject {

    public interface Attributes {
        String BRAND = "brand";
        String NAME = "name";
        String PRICE = "price";
        String TYPE = "type";
    }

    public interface Relationships {
        String SHOP = "shop";
    }

    private String brand;
    private String name;
    private int price;
    @Ignore
    private TypeA typeEnum;
    private String type;
    private Shop shop;

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

    public String getType() {
        return type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    public TypeA getTypeEnum() {
        return TypeA.get(getType());
    }

    public void setTypeEnum(final TypeA type) {
        this.type = type.getJsonValue();
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(final Shop shop) {
        this.shop = shop;
    }
}
