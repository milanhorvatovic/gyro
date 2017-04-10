package fr.ganfra.realm;

/* DO NOT EDIT | Generated by gyro */

public enum Type {

    TYPE_ONE("json_type_one"),
    TYPE_TWO("json_type_two"),
    TYPE_THREE("json_type_three");

    private final String jsonValue;

    Type(final String jsonValue) {
        this.jsonValue = jsonValue;
    }

    public static Type get(final String jsonValue) {
        for (final Type type : Type.values()) {
            if (type.getJsonValue().equals(jsonValue)) {
                return type;
            }
        }
        return null;
    }

    public String getJsonValue() {
        return jsonValue;
    }
}
