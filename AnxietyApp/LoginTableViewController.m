//
//  LoginTableViewController.m
//  AnxietyApp
//
//  Created by Div Bhasin on 2018-05-05.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import "LoginTableViewController.h"
#import "User.h"
@import FirebaseAuth;
@import FirebaseDatabase;
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.ref = [[FIRDatabase database] reference];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(Login_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *login = [[UIBarButtonItem alloc] initWithCustomView:button];
    login.tintColor = [UIColor colorWithRed:0 green:0 blue:120 alpha:1];
    
    FBSDKLoginButton *fb_login = [[FBSDKLoginButton alloc] init];
    super.navigationItem.leftBarButtonItem = login;
    fb_login.center = self.view.center;
    fb_login.delegate = self;
    
    [self.view addSubview:fb_login];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

- (IBAction)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error occured.");
            }
            // User successfully signed in. Get user data from the FIRUser object
            // ...
        }];
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)setTitleDisplay:(FIRUser *)user {
    if (user.displayName) {
        self.navigationItem.title = [NSString stringWithFormat:@"Welcome %@", user.displayName];
    } else {
        self.navigationItem.title = @"Authentication failed";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
                       [self setTitleDisplay:user];
                       [self.tableView reloadData];
                   }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Login_Action:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login" message: @"Please login" preferredStyle: UIAlertControllerStyleAlert];

    UITextField __block *email_field;
    UITextField __block *password_field;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
        email_field = textField;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Password";
        password_field = textField;
    }];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[FIRAuth auth] createUserWithEmail:email_field.text
                                   password:password_field.text
                                 completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                     NSLog(@"User created");
                                 }];
    }]];

    [alert addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
