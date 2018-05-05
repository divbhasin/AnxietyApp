//
//  LoginTableViewController.h
//  AnxietyApp
//
//  Created by Div Bhasin on 2018-05-05.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;

@interface LoginTableViewController : UITableViewController

@property (strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (strong, nonatomic) UIBarButtonItem *login;
- (IBAction)Login_Action:(UIBarButtonItem *)sender;

@end
