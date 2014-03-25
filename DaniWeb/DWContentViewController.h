//
//  DWContentViewController.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/23/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWContentViewController : UIViewController
- (IBAction)contentPanned:(id)sender;
- (void) openMenuForItem:(NSString *) string;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@end
