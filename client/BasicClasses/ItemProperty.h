//
//  ItemProperty.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface ItemProperty : AbstractBasicClass {
    NSNumber *itemID;
    NSString *itemName;
    NSNumber *propertyID;
    NSString *propertyName;
    NSString *value;
}

@property(nonatomic, strong) NSNumber *itemID;
@property(nonatomic, strong) NSString *itemName;
@property(nonatomic, strong) NSNumber *propertyID;
@property(nonatomic, strong) NSString *propertyName;
@property(nonatomic, strong) NSString *value;

@end
