//
//  MenuItemCell.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 22.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *labelName;

@property (strong, nonatomic) IBOutlet UILabel *labelPrice;

@property (strong, nonatomic) IBOutlet UILabel *labelDescr;

@end
