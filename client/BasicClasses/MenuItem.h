//
//  MenuItem.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface MenuItem : AbstractBasicClass {
    NSString *name;
    NSString *description;
    NSNumber *menuID;
    NSNumber *groupID;
    NSNumber *itemID;
    NSString *photo;
    NSNumber *cost;
}

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSNumber *menuID;
@property(nonatomic, strong) NSNumber *groupID;
@property(nonatomic, strong) NSNumber *itemID;
@property(nonatomic, strong) NSString *photo;
@property(nonatomic, strong) NSNumber *cost;

@end

