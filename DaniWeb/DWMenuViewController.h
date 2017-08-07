//
//  DWViewController.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 2/26/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DWDealer;
@class DWNavigationViewController;

@interface DWMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *entireContiner;


@property DWNavigationViewController * stuffController;
@end
