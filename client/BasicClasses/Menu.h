//
//  Menu.h
//
//  Created by Alexey Kolosov on 11.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBasicClass.h"

@interface Menu : AbstractBasicClass {
    NSString *name;
    NSString *startdate;
    NSString *enddate;
}

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *startdate;
@property(nonatomic, strong) NSString *enddate;

@end
