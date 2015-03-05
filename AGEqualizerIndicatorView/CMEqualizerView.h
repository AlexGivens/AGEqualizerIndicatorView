//
//  CMEqualizerView.h
//  Color Myx
//
//  Created by Alexander Givens on 9/2/14.
//  Copyright (c) 2014 Jingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMEqualizerView : UIView

@property (nonatomic) int bpm;

- (void)startAnimated:(BOOL)animated;
- (void)pauseAnimated:(BOOL)animated;
- (void)stopAnimated:(BOOL)animated;

@end
