//
//  Group.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface Group : AbstractBasicClass {
    NSString *photo;
    NSString *name;
    NSString *description;
}

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSString *photo;

@end
