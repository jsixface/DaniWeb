//
//  DWNavigationViewController.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/5/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWContentViewController.h"

@interface DWNavigationViewController : UINavigationController<UINavigationControllerDelegate>

@property(strong, nonatomic) DWContentViewController * rootController;
- (void) openMenuForItem:(NSString *) string;
-(void) toggleContent;


@end
