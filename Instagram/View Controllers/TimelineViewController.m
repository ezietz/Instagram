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
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.postArray = [[NSMutableArray alloc] init];
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Instagram"];

}

- (void) fetchPosts {
    [self fetchPostsWithFilter:nil];
}

- (void) fetchPostsWithFilter: (NSDate *) lastDate {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    if (lastDate) {
        [postQuery whereKey:@"createdAt" lessThan:lastDate];
    }
    postQuery.limit = 20;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if ([posts count] != 0) {
            if (lastDate) {
                self.isMoreDataLoading = false;
                [self.postArray addObjectsFromArray:posts];
            } else {
                self.postArray = posts;
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)clickedLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(PFUser.currentUser == nil) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
            
            NSLog(@"User logged out successfully");
        } else {
            NSLog(@"Error logging out: %@", error);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postArray[indexPath.row];
    cell.post = post;
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.photoView.image = [UIImage imageWithData:data];
    }];
    cell.captionText.text = post.caption;
    cell.userText.text = post.author.username;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        PostCell *tappedCell = sender;
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = tappedCell.post;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading) {
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            Post *lastPost = [self.postArray lastObject];
            NSDate *lastDate = lastPost.createdAt;
            [self fetchPostsWithFilter:lastDate];
        }
    }
}
    
@end
