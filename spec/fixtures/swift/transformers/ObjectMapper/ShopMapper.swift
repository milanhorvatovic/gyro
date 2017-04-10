/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension Shop: Mappable {

  // MARK: Initializers

  convenience init?(_ map: Map) {
    self.init()
  }

  // MARK: Mappable

  func mapping(map: Map) {

    // MARK: Attributes
    self.attrDate <- (map["attrDate"], ISO8601DateTransform())
    self.attrDateCustom <- (map["attrDateCustom"], CustomDateTransformer())
    self.attrDecimal <- map["attrDecimal"]
    self.attrDouble <- map["attrDouble"]
    self.attrFloat <- map["attrFloat"]
    self.attrInteger16 <- map["attrInteger16"]
    self.attrInteger32 <- map["attrInteger32"]
    self.attrInteger64 <- map["attrInteger64"]
  }
}
