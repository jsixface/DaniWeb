//
//  DWLoadingView.m
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 5/20/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import "DWLoadingView.h"

@implementation DWLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:96.0/255 green:64.0/255 blue:128.0/255 alpha:.85];
//        NSURL * imageUrl = [[NSBundle mainBundle] URLForResource:@"loading" withExtension:@"gif"];
        UIImage * loadingImage = [UIImage animatedImageNamed:@"loading" duration:3];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:loadingImage];
        
        CGRect imageFrame = CGRectMake((frame.size.width - loadingImage.size.width)/2,
                                       (frame.size.height - loadingImage.size.height)/2,
                                       loadingImage.size.width,
                                       loadingImage.size.height);
        imageView.frame = imageFrame;
        self.tag= DW_LOADING_TAG;
        [self addSubview:imageView];
    }
    return self;
}


@end
