//
//  Response.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface Response : AbstractBasicClass {
    NSNumber *userID;
    NSString *session;
    NSString *result;
}

@property(nonatomic, strong) NSNumber *userID;
@property(nonatomic, strong) NSString *session;
@property(nonatomic, strong) NSString *result;

@end
