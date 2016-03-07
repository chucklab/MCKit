//
//  MCDemoBaseViewController.m
//  MCKitDemo
//
//  Created by 马超(Ma Chao) on 2016/3/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCDemoBaseViewController.h"

@interface MCDemoBaseViewController ()

@end

@implementation MCDemoBaseViewController

- (id)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        // Setups.
        self.titleBarViewBackgroundColor = [UIColor redColor];
        self.titleLableFont = [UIFont systemFontOfSize:18];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
