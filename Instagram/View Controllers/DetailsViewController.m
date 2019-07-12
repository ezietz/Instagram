//
//  DetailsViewController.m
//  Instagram
//
//  Created by ezietz on 7/9/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "Post.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *timeField;
@property (weak, nonatomic) IBOutlet UILabel *captionField;
@property (weak, nonatomic) IBOutlet UILabel *userText;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        self.photoView.image = [UIImage imageWithData:data];
    }];
    self.captionField.text = self.post.caption;
    self.userText.text = self.post.author.username;
    NSDate *createdAt = [self.post createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E MMM d HH:mm:ss y"];
    NSString *stringFromDate = [formatter stringFromDate:createdAt];
    self.timeField.text = stringFromDate;
}

@end
