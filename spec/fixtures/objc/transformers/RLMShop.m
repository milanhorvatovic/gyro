// DO NOT EDIT | Generated by dbgenerator

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Imports

#import "RLMShop.h"

#pragma mark - Defines & Constants

const struct RLMShopAttributes RLMShopAttributes = {
    .attrDecimal = @"attrDecimal",
    .attrDouble = @"attrDouble",
    .attrFloat = @"attrFloat",
    .attrInteger16 = @"attrInteger16",
    .attrInteger32 = @"attrInteger32",
    .attrInteger64 = @"attrInteger64"
};

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Implementation

@implementation RLMShop

#pragma mark - Superclass Overrides

// Specify required properties
+ (NSArray *)requiredProperties
{
    return @[@"attrDecimal", @"attrDouble", @"attrFloat", @"attrInteger16", @"attrInteger32", @"attrInteger64"];
}

// Specify default values for required properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"attrDecimal" : @(0.0), @"attrDouble" : @(0.0), @"attrFloat" : @(0.0), @"attrInteger16" : @(0), @"attrInteger32" : @(0), @"attrInteger64" : @(0)};
}

@end