//
//  ViewController.m
//  Example
//
//  Created by Alexander Givens on 3/4/15.
//  Copyright (c) 2015 Alex Givens. All rights reserved.
//

#import "ViewController.h"
#import "AGEqualizerIndicatorView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AGEqualizerIndicatorView *equalizerIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.equalizerIndicatorView startAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
