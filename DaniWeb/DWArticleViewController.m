//
//  DWArticleViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/7/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWArticleViewController.h"


@interface DWArticleViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *textArticleView;

@end

@implementation DWArticleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViewForPost:(int)postId
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            
//            NSArray * posts = [_dealer getContentForArticleID:[NSString stringWithFormat:@"%d", postId]];
//            NSString * content = @"";
//            for (NSDictionary * post in posts) {
//                content = [content stringByAppendingString:post[@"parsed_message"]];
//                content = [content stringByAppendingString:@"<br /><hr /><br />"];
//            }
//            [self.textArticleView loadHTMLString:content baseURL:nil];
//            
//            // remove the loading view
//            NSArray *subviews = self.view.subviews;
//            for (UIView * subview in subviews) {
//                if (subview.tag == DW_LOADING_TAG) {
//                    [subview removeFromSuperview];
//                    break;
//                }
//            }
//        });
//    });

}

@end
