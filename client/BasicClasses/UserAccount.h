//
//  UserAccount.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface UserAccount : AbstractBasicClass {
    NSNumber *userID;
    NSString *code;
    NSNumber *bonus;
    NSNumber *used;
    NSString *expireday;
}

@property(nonatomic, strong) NSNumber *userID;
@property(nonatomic, strong) NSNumber *bonus;
@property(nonatomic, strong) NSNumber *used;
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *expireday;

@end
