//
//  TimelineViewController.m
//  Instagram
//
//  Created by ezietz on 7/8/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PostCell.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postArray;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchPosts];
}

- (void) fetchPosts{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSLog(@"Successfully loaded home timeline!");
            self.postArray = posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error");
            // handle error
        }
    }];
}
- (IBAction)clickedLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
    NSLog(@"User logged out successfully");
    
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    
    LoginViewController *loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:loginController];
    appDelegateTemp.window.rootViewController = navigation;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postArray[indexPath.row];
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        // Do something with the image
        cell.photoView.image = [UIImage imageWithData:data];
    }];
    
    cell.captionText.text = post.caption;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

@end
    
//    [loginViewController setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:loginViewController animated:NO completion:nil];


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
