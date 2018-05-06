//
//  LoginTableViewController.h
//  AnxietyApp
//
//  Created by Div Bhasin on 2018-05-05.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;
@import FirebaseDatabase;

@interface LoginTableViewController : UITableViewController

@property (strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (strong, nonatomic) UIBarButtonItem *login;
@property (strong, nonatomic) FIRDatabaseReference *ref;
- (IBAction)Login_Action:(UIBarButtonItem *)sender;

@end
