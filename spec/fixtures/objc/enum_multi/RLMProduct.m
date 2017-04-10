// DO NOT EDIT | Generated by gyro

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Imports

#import "RLMProduct.h"

#pragma mark - Defines & Constants

const struct RLMProductAttributes RLMProductAttributes = {
    .brand = @"brand",
    .name = @"name",
    .price = @"price",
    .type = @"type"
};

const struct RLMProductRelationships RLMProductRelationships = {
    .shop = @"shop"
};

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Implementation

@implementation RLMProduct

#pragma mark - Superclass Overrides

// Specify required properties
+ (NSArray *)requiredProperties
{
    return @[@"brand", @"name", @"price", @"type"];
}

// Specify default values for required properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"brand" : @"", @"name" : @"", @"price" : @(0), @"type" : @(0)};
}

@end
