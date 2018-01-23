/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaPromotionProxy.h"

@implementation TiGaPromotionProxy

- (void)_initWithProperties:(NSDictionary *)properties
{
    id identifier = [properties objectForKey:@"id"];
    id name = [properties objectForKey:@"name"];
    id creative = [properties objectForKey:@"creative"];
    id position = [properties objectForKey:@"position"];
    
    ENSURE_TYPE(identifier, NSString);
    ENSURE_TYPE(name, NSString);
    ENSURE_TYPE_OR_NIL(creative, NSString);
    ENSURE_TYPE_OR_NIL(position, NSString);
    
    _descriptor = [[NSMutableDictionary alloc] initWithDictionary:properties];
    _promotion = [[GAIEcommercePromotion alloc] init];
    
    [_promotion setId:identifier];
    [_promotion setName:name];
    [_promotion setCreative:creative];
    [_promotion setPosition:position];
    
    [super _initWithProperties: properties];
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

- (void)log:(NSString*)string forLevel:(NSString*)level
{
    NSLog(@"[%@] %@: %@", [level uppercaseString], NSStringFromClass([self class]), string);
}

@end
