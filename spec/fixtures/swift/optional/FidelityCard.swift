/* DO NOT EDIT | Generated by gyro */

import RealmSwift

final class FidelityCard: Object {

  enum Attributes: String {
    case identifier = "identifier"
    case points = "points"
  }

  enum Relationships: String {
    case user = "user"
  }

  dynamic var identifier: Int16 = 0
  let points = RealmOptional<Int32>()
  dynamic var user: User?

}
