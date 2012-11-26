//
//  Order.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface Order : AbstractBasicClass {
    NSNumber *userID;
    NSString *session;
    NSString *name;
    NSString *phone;
    NSString *address;
    NSString *status;
    NSNumber *summ;
}

@property(nonatomic, strong) NSNumber *userID;
@property(nonatomic, strong) NSString *session;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSNumber *summ;

@end
