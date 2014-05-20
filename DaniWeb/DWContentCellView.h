//
//  DWContentCellView.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 4/9/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWContentCellView : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *txtTitle;
@property (strong, nonatomic) IBOutlet UILabel *txtAuthor;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) IBOutlet UIView *cellBackgroundView;
@end
