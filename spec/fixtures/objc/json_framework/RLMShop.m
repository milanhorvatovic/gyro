// DO NOT EDIT | Generated by gyro

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Imports

#import "RLMShop.h"

#pragma mark - Defines & Constants

const struct RLMShopAttributes RLMShopAttributes = {
    .name = @"name"
};

const struct RLMShopRelationships RLMShopRelationships = {
    .products = @"products"
};

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Implementation

@implementation RLMShop

#pragma mark - Superclass Overrides

// Specify required properties
+ (NSArray *)requiredProperties
{
    return @[@"name"];
}

// Specify default values for required properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"name" : @""};
}

@end
