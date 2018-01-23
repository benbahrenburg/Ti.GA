/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaProductActionProxy.h"

@implementation TiGaProductActionProxy

- (void)_initWithProperties:(NSDictionary *)properties
{
    if ([properties objectForKey:@"type"] != nil) {
        id type = [properties objectForKey:@"type"];
        id transaction = [properties objectForKey:@"transaction"];
        id checkout = [properties objectForKey:@"checkout"];
        id list = [properties objectForKey:@"list"];
        
        ENSURE_TYPE(type, NSString);
        ENSURE_TYPE_OR_NIL(transaction, NSDictionary);
        ENSURE_TYPE_OR_NIL(checkout, NSDictionary);
        ENSURE_TYPE_OR_NIL(list, NSDictionary);
        
        _descriptor = [NSMutableDictionary dictionaryWithDictionary:properties];
        _productAction = [[GAIEcommerceProductAction alloc] init];
        
        [_productAction setAction:type];
        
        if (transaction != nil) {
            [self handleTransaction:transaction];
        }
        
        if (checkout != nil) {
            [self handleCheckout:checkout];
        }
        
        if (list != nil) {
            [self handleList:list];
        }
    } else {
        [self log:@"Unable to create a ProductAction. Missing 'type' property in creation dictionary" forLevel:@"error"];
    }
    
    [super _initWithProperties: properties];
}

#pragma mark Public APIs

- (void)setTransaction:(id)args
{
    ENSURE_UI_THREAD(setTransaction, args);
    ENSURE_ARG_COUNT(args, 1);
    ENSURE_TYPE(args, NSDictionary);
    
    NSDictionary* transaction = args;
    
    [_descriptor setValue:args forKey:@"transaction"];
    
    [self handleTransaction:transaction];
}

- (void)setCheckout:(id)args
{
    ENSURE_UI_THREAD(setCheckout, args);
    ENSURE_ARG_COUNT(args, 1);
    ENSURE_TYPE(args, NSDictionary);
    
    NSDictionary* checkout = args;
    
    [_descriptor setValue:args forKey:@"checkout"];
    
    [self handleCheckout:checkout];
}

- (void)setList:(id)args
{
    ENSURE_UI_THREAD(setList, args);
    ENSURE_ARG_COUNT(args, 1);
    ENSURE_TYPE(args, NSDictionary);
    
    NSDictionary* list = args;
    
    [_descriptor setValue:args forKey:@"list"];
    
    [self handleList:list];
}

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

- (void)handleTransaction:(NSDictionary*)transaction
{
    id identifier = [transaction objectForKey:@"id"];
    id affiliation = [transaction objectForKey:@"affiliation"];
    id coupon = [transaction objectForKey:@"coupon"];
    id tax = [transaction objectForKey:@"tax"];
    id revenue = [transaction objectForKey:@"revenue"];
    id shipping = [transaction objectForKey:@"shipping"];
    
    ENSURE_TYPE(identifier, NSString);
    ENSURE_TYPE_OR_NIL(affiliation, NSString);
    ENSURE_TYPE_OR_NIL(coupon, NSString);
    ENSURE_TYPE_OR_NIL(tax, NSNumber);
    ENSURE_TYPE_OR_NIL(revenue, NSNumber);
    ENSURE_TYPE_OR_NIL(shipping, NSNumber);

    [_productAction setTransactionId:identifier];
    [_productAction setAffiliation:affiliation];
    [_productAction setCouponCode:coupon];
    [_productAction setTax:tax];
    [_productAction setRevenue:revenue];
    [_productAction setShipping:shipping];
}

- (void)handleCheckout:(NSDictionary*)checkout
{
    id step = [checkout objectForKey:@"step"];
    id option = [checkout objectForKey:@"options"];
    
    ENSURE_TYPE_OR_NIL(step, NSNumber);
    ENSURE_TYPE_OR_NIL(option, NSString);
    
    [_productAction setCheckoutStep:step];
    [_productAction setCheckoutOption:option];
}

- (void)handleList:(NSDictionary*)list
{
    id name = [list objectForKey:@"name"];
    id source = [list objectForKey:@"source"];
    
    ENSURE_TYPE_OR_NIL(name, NSString);
    ENSURE_TYPE_OR_NIL(source, NSString);
    
    [_productAction setProductActionList:name];
    [_productAction setProductListSource:source];
}

- (void)log:(NSString*)string forLevel:(NSString*)level
{
    NSLog(@"[%@] %@: %@", [level uppercaseString], NSStringFromClass([self class]), string);
}

@end
