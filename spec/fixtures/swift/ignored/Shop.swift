/* DO NOT EDIT | Generated by dbgenerator */

import RealmSwift

class Shop : Object {

    enum Attributes : String {
        case Name = "name"
    }

    enum Relationships : String {
        case Owner = "owner"
        case Products = "products"
    }

    dynamic var ignored = ""
    dynamic var name = ""
    dynamic var owner :Owner?
    let products = List<Product>()

    // Specify properties to ignore (Realm won't persist these)
    override static func ignoredProperties() -> [String] {
        return ["ignored"]
    }

}