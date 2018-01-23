/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "GAIEcommerceProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiGaProductProxy : TiProxy {

}

@property (nonatomic, retain) GAIEcommerceProduct* product;
@property (nonatomic, retain) NSDictionary* descriptor;

- (NSString*)toString:(id __nullable)unused;

@end

NS_ASSUME_NONNULL_END
