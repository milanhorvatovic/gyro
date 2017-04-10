package fr.ganfra.realm;

/* DO NOT EDIT | Generated by gyro */

public enum TypeA {

    TYPE_ONE("type_a_one"),
    TYPE_TWO("type_a_two"),
    TYPE_THREE("type_a_three");

    private final String jsonValue;

    TypeA(final String jsonValue) {
        this.jsonValue = jsonValue;
    }

    public static TypeA get(final String jsonValue) {
        for (final TypeA type : TypeA.values()) {
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
