/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaProductProxy.h"
#import "TiUtils.h"

@implementation TiGaProductProxy

- (void)_initWithProperties:(NSDictionary *)properties
{
    id identifier = [properties valueForKey:@"id"];
    id name = [properties valueForKey:@"name"];
    id price = [properties valueForKey:@"price"];
    id quantity = [properties valueForKey:@"quantity"];
    id category = [properties valueForKey:@"category"];
    id brand = [properties valueForKey:@"brand"];
    id variant = [properties valueForKey:@"variant"];
    id position = [properties valueForKey:@"position"];
    id coupon = [properties valueForKey:@"coupon"];
    id customDimensions = [properties valueForKey:@"customDimensions"];
    id customMetrics = [properties valueForKey:@"customMetrics"];
    
    ENSURE_TYPE(identifier, NSString);
    ENSURE_TYPE(name, NSString);
    ENSURE_TYPE(price, NSNumber);
    ENSURE_TYPE(quantity, NSNumber);
    ENSURE_TYPE_OR_NIL(category, NSString);
    ENSURE_TYPE_OR_NIL(brand, NSString);
    ENSURE_TYPE_OR_NIL(variant, NSString);
    ENSURE_TYPE_OR_NIL(position, NSNumber);
    ENSURE_TYPE_OR_NIL(coupon, NSString);
    ENSURE_TYPE_OR_NIL(customDimensions, NSDictionary);
    ENSURE_TYPE_OR_NIL(customMetrics, NSDictionary);
    
    _descriptor = [[NSDictionary alloc] initWithDictionary:properties];
    _product = [[GAIEcommerceProduct alloc] init];
    
    [_product setId:identifier];
    [_product setName:name];
    [_product setPrice:price];
    [_product setQuantity:quantity];
    [_product setCategory:category];
    [_product setBrand:brand];
    [_product setVariant:variant];
    [_product setPosition:position];
    [_product setCouponCode:coupon];
    
    if (customDimensions != nil) {
        [self handleCustomDimensions:customDimensions];
    }
    
    if (customMetrics != nil) {
        [self handleCustomMetrics:customMetrics];
    }
    
    [super _initWithProperties:properties];
}

#pragma mark Public APIs

- (NSString*)toString:(id)unused
{
    NSMutableArray* components = [[NSMutableArray alloc] init];
    
    for (NSString* key in [_descriptor allKeys]) {
        id current = [_descriptor objectForKey:key];
        
        [components addObject:[NSString stringWithFormat:@"%@: %@", key, current]];
    }
    
    return [components componentsJoinedByString:@"\n"];
}

#pragma mark Internals

- (void)handleCustomDimensions:(NSDictionary*)dimensions
{
    [dimensions enumerateKeysAndObjectsUsingBlock:^(id key, NSString* value, BOOL* stop) {
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        NSNumber* index = [formatter numberFromString:key];
        
        [_product setCustomDimension:[index unsignedIntegerValue] value:value];
    }];
}

- (void)handleCustomMetrics:(NSDictionary*)metrics
{
    [metrics enumerateKeysAndObjectsUsingBlock:^(id key, NSNumber* value, BOOL* stop) {
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        NSNumber* index = [formatter numberFromString:key];
        
        [_product setCustomMetric:[index unsignedIntegerValue] value:value];
    }];
}

- (void)log:(NSString*)string forLevel:(NSString*)level
{
    NSLog(@"[%@] %@: %@", [level uppercaseString], NSStringFromClass([self class]), string);
}

@end
