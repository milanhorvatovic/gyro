/* DO NOT EDIT | Generated by gyro */

import RealmSwift

final class Owner: Object {

    enum Attributes: String {
        case Name = "name"
    }

    enum Relationships: String {
        case Shop = "shop"
    }

    dynamic var name: String? = nil
    dynamic var shop: Shop?

    // Specify properties to ignore (Realm won't persist these)
    override static func ignoredProperties() -> [String] {
        return ["shop"]
    }

}
