//
//  User.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface User : AbstractBasicClass {
    NSString *name;
    NSString *email;
    NSString *phone;
    NSString *address;
    NSString *birthday;
}

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *birthday;

@end

