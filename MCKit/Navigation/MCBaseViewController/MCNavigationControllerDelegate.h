//
//  MCNavigationControllerDelegate.h
//  MCKit <https://github.com/imegatron/MCKit>
//
//  Created by 马超(Ma Chao) on 2015/11/24.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCNavigationControllerDelegate : NSObject <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

#pragma mark - Main Init.
- (id)initWithNavigationController:(UINavigationController *)navigationController;

#pragma mark - Singleton
//+ (MCNavigationControllerDelegate *)sharedInstance;

@end
