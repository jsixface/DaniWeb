//
//  DWContentViewController.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/23/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWContentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

- (void) openMenuForItem:(NSDictionary *) string;

@end
