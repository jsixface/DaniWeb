//
//  DWArticleViewController.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/7/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWArticleViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textArticleView;
@property (strong, nonatomic) NSString* textContent;
@end
