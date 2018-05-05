//
//  User.m
//  AnxietyApp
//
//  Created by Div Bhasin on 2018-05-05.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import FirebaseAuth;
#import "User.h"

@implementation User

- (void)init:(FIRUser *)userData {
    self.uid = userData.uid;
    
    if (userData.providerData.count) {
        if (userData.providerData.firstObject.email != NULL) {
            self.email = userData.providerData.firstObject.email;
        }
        else {
            self.email = @"";
        }
    }
}

- (void)init:(NSString *)email withPassword:(NSString *) pass {
    self.password = pass;
    self.email = email;
}

@end
