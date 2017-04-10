/* DO NOT EDIT | Generated by gyro */

import RealmSwift

final class Shop: Object {

    enum Attributes: String {
        case Name = "name"
        case OptionalValue = "optionalValue"
        case Type = "type"
    }

    dynamic var name: String = ""
    dynamic var optionalValue: String? = nil
    var optionalValueEnum: OptValue? {
        get {
            guard let optionalValue = optionalValue,
              let enumValue = OptValue(rawValue: optionalValue)
              else { return nil }
            return enumValue
        }
        set { optionalValue = newValue?.rawValue ?? nil }
    }

    dynamic var type: String = ""
    var typeEnum: Type? {
        get {
            guard let enumValue = Type(rawValue: type) else { return nil }
            return enumValue
        }
        set { type = newValue?.rawValue ?? "" }
    }


}
