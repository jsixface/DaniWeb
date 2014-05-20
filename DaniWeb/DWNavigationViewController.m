//
//  DWNavigationViewController.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/5/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWNavigationViewController.h"


@interface DWNavigationViewController ()
@property (nonatomic) BOOL contentSlided;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic) CGFloat halfWidth;
@property (nonatomic) CGFloat eightyThresholdPoint ;
@property (nonatomic) CGPoint touchStartPoint;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;
@end

@implementation DWNavigationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.originalFrame = self.view.frame;
    self.halfWidth = self.originalFrame.size.width/2;
    self.eightyThresholdPoint = (_originalFrame.origin.x + _originalFrame.size.width) * DW_CONTENT_SLIDE_PERCENT;
    self.rootController = self.viewControllers.firstObject;
    self.rootController.view.gestureRecognizers = @[self.panGesture, self.tapGesture];
    
    // set the shadow of the content
    CALayer* layer = self.view.layer;
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(-5,-5);
    layer.shadowRadius = 8.0f;
    layer.shadowOpacity  = 0.8f;
    layer.shadowPath  = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
}


- (IBAction)contentPanned:(UIPanGestureRecognizer *)sender
{
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

- (IBAction)contentTapped:(UITapGestureRecognizer *)sender
{
    [self toggleContent];
}

- (void) openMenuForItem:(NSDictionary *) values
{
    [self.rootController openMenuForItem:values ];
    [self slideBackToPosition];
}

#pragma mark - Sliding parts

-(void)toggleContent
{
    if(self.contentSlided)
        [self slideBackToPosition];
    else
        [self slideOut];
}

-(void) slideBackToPosition
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = _originalFrame;
                     }
                     completion:^(BOOL completed){
                         _contentSlided = false;
                         self.tapGesture.enabled  = false;
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
                         self.tapGesture.enabled = true;
                     }];
    
}

#pragma mark - Navigation Delegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.rootController)
        self.panGesture.enabled =true;
    else
        self.panGesture.enabled = false;
}

@end
