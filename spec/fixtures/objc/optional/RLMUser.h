// DO NOT EDIT | Generated by gyro

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Imports

#import <Realm/Realm.h>

#pragma mark - Types

@class RLMFidelityCard;

#pragma mark - Defines & Constants

extern const struct RLMUserAttributes {
    __unsafe_unretained NSString *birthday;
    __unsafe_unretained NSString *name;
} RLMUserAttributes;

extern const struct RLMUserRelationships {
    __unsafe_unretained NSString *fidelityCard;
} RLMUserRelationships;

////////////////////////////////////////////////////////////////////////////////

#pragma mark - Interface

@interface RLMUser : RLMObject

#pragma mark - Properties

@property NSDate *birthday;
@property NSString *name;
@property RLMFidelityCard *fidelityCard;

@end
