package fr.ganfra.realm;

import java.util.Date;

import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;

/* DO NOT EDIT | Generated by gyro */

public class User extends RealmObject {

    public interface Attributes {
        String BIRTHDAY = "birthday";
        String NAME = "name";
    }

    public interface Relationships {
        String FIDELITY_CARD = "fidelityCard";
    }

    private Date birthday;
    @PrimaryKey
    private String name;
    private FidelityCard fidelityCard;

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(final Date birthday) {
        this.birthday = birthday;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public FidelityCard getFidelityCard() {
        return fidelityCard;
    }

    public void setFidelityCard(final FidelityCard fidelityCard) {
        this.fidelityCard = fidelityCard;
    }
}
