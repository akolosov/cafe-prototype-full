//
//  GameViewController.h
//  cafePrototype
//
//  Created by Alexey Kolosov on 19.05.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) AppDelegate * myApp;
@property (strong, nonatomic) IBOutlet UILabel *lblOne;
@property (strong, nonatomic) IBOutlet UILabel *lblTwo;
@property (strong, nonatomic) IBOutlet UILabel *lblThree;

@property (strong, nonatomic) IBOutlet UIButton *actionButton;

- (IBAction)letsPlay:(id)sender;

@end
