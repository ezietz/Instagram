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
    
    NSDate *createdAt = [self.post createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E MMM d HH:mm:ss y"];
    NSString *stringFromDate = [formatter stringFromDate:createdAt];
    self.timeField.text = stringFromDate;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
