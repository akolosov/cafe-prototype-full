//
//  OrderItemCell.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 22.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "OrderItemCell.h"

@implementation OrderItemCell

@synthesize labelDescr, imageView, labelName, labelPrice, labelCount, labelSumm;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
