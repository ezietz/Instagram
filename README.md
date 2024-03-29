# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **22** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [x] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
- [x] Allow the logged in user to add a profile photo
- [x] Display the profile photo with each post
- [x] Tapping on a post's username or profile photo goes to that user's profile page
- [x] User can like a post and see number of likes for each post in the post details screen.
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] Run your app on your phone and use the camera to take the photo
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [x] Added tab bar to allow user to smoothly transition between viewing their feed and accessing the camera
- [x] Added real Instagram title on applicable screens
- [x] Allowed user to see how many posts they have made on their profile view
- [x] Customized the selection effect of each post cell 
- [x] Customized the navigation bar to have Instagram logo
- [x] Allowed user to pull to refresh in order to view their posts in profile view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I'd like to discuss how to implement the custom camera view.
2. I'm curious about how to implement the messaging between users. I think it would have similar features to the Parse Chat we implemented earlier.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

User can register for a new account, as well as log in.
<img src='http://g.recordit.co/WPI7fmcgkL.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can logout, log back in, and set and change their profile picture.
<img src='http://g.recordit.co/zb44VPapCy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can create a post and post it to their timeline, as well as view all of their posts in their own profile tab.
<img src='http://g.recordit.co/hKgS8WBipE.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can like posts, unlike posts, tap on a post to view post details, and tap on the author of the post's profile photo to visit that user's profile page and view their previous posts.
<img src='http://g.recordit.co/zDEDfekmH2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [Recordit].

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## Notes

Describe any challenges encountered while building the app.

Understanding how to allow the user to tap on a post's username or profile photo and go to that user's profile page was challenging at first. I realized that I needed to set the segue from the Timeline View Controller to the Profile View Controller. The infinite scroll was also quite hard to implement. It scrolled to see more posts correctly, but I realized I also had to check whether I had reached the last post, because there is a finite number of posts my users have posted.

## License

Copyright [2019] [Elizabeth Zietz]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
