//
//  OrderItem.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface OrderItem : AbstractBasicClass {
    NSString *name;
    NSString *description;
    NSNumber *orderID;
    NSNumber *itemID;
    NSString *photo;
    NSNumber *cost;
    NSNumber *count;
    NSNumber *summ;
}

@property(nonatomic, strong) NSNumber *itemID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSNumber *orderID;
@property(nonatomic, strong) NSString *photo;
@property(nonatomic, strong) NSNumber *cost;
@property(nonatomic, strong) NSNumber *count;
@property(nonatomic, strong) NSNumber *summ;

@end
