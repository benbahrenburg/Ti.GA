/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "GAIEcommerceProductAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiGaProductActionProxy : TiProxy {

}

@property (nonatomic, retain) GAIEcommerceProductAction* productAction;
@property (nonatomic, retain) NSMutableDictionary* descriptor;

- (void)setTransaction:(id)args;
- (void)setCheckout:(id)args;
- (void)setList:(id)args;
- (NSString* )toString:(id __nullable)unused;

@end

NS_ASSUME_NONNULL_END
