//
//  MCHallViewController.m
//  MCKitDemo
//
//  Created by 马超(Ma Chao) on 2016/3/7.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCHallViewController.h"

@interface MCHallViewController ()

@property (nonatomic, strong) UIView *mainView;

@end

@implementation MCHallViewController

- (id)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        self.titleBarView.rightButton.hidden = YES;
        //self.titleText = @"首页";
        self.titleText = @"操场";
        self.titleBarView.leftButton.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _mainView = [[UIView alloc]initWithFrame:StaticFrame];
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
