//
//  DWContentViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 3/23/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWContentViewController.h"


@interface DWContentViewController ()

@end


CGRect _originalFrame ;
CGFloat _halfWidth;
CGPoint _touchStartPoint;
BOOL _slideStarted;
BOOL _contentSlided = false;
CGFloat _eightyThresholdPoint ;

@implementation DWContentViewController

@synthesize panGesture = _panGesture;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _originalFrame = self.view.frame;
    _halfWidth = _originalFrame.size.width/2;
    _eightyThresholdPoint =(_originalFrame.origin.x + _originalFrame.size.width) * 0.8;
    
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)contentPanned:(id)sender {
    
    CGPoint touchPoint = [_panGesture locationInView:self.view.superview];
    CGFloat translation = touchPoint.x - _touchStartPoint.x;
    
    if (_panGesture.state == UIGestureRecognizerStateBegan)
    {
        _touchStartPoint = touchPoint;
        if (touchPoint.x > _eightyThresholdPoint && !_contentSlided)
        {
            _panGesture.enabled=false;
            _panGesture.enabled=true;
        }
    }
    if (_panGesture.state == UIGestureRecognizerStateChanged )
    {
        if ( translation > 0 && !_contentSlided )
        {
            // If the frame is moved more than width/2 or reaches the edge, kill the gesture
            // and do the rest of the movement through animation.
            
            if (translation >= _halfWidth || touchPoint.x > _eightyThresholdPoint)
            {
                _panGesture.enabled=false;
                _panGesture.enabled=true;
                [self slideOut];
                return;
            }
            CGRect newFrame  = CGRectMake(_originalFrame.origin.x + translation,
                                          _originalFrame.origin.y,
                                          _originalFrame.size.width,
                                          _originalFrame.size.height);
            self.view.frame = newFrame;
        }
        else if( _contentSlided && translation < 0 )
        {
            if (translation < -_halfWidth/3 )
            {
                _panGesture.enabled=false;
                _panGesture.enabled=true;
                [self slideBackToPosition];
                return;
            }
            CGRect newFrame  = CGRectMake(_eightyThresholdPoint + translation,
                                          _originalFrame.origin.y,
                                          _originalFrame.size.width,
                                          _originalFrame.size.height);
            self.view.frame = newFrame;
        }
    }
    else if (_panGesture.state == UIGestureRecognizerStateEnded)
    {
        if(!_contentSlided )
            [self slideBackToPosition];
        else
            [self slideOut];
    }
}

-(void) openMenuForItem:(NSString *) string
{
    self.lblTitle.text = string;
    [self slideBackToPosition];
}

-(void) slideBackToPosition
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = _originalFrame;
                     }
                     completion:^(BOOL completed){
                         _contentSlided = false;
                     }];
}

-(void) slideOut
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect newFrame = CGRectMake(_eightyThresholdPoint,
                                                      _originalFrame.origin.y,
                                                      _originalFrame.size.width,
                                                      _originalFrame.size.height);
                         self.view.frame = newFrame;
                     }
                     completion:^(BOOL completed){
                         _contentSlided = true;
                     }];
    
}

@end
