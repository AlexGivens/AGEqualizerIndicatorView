//
//  AGEqualizerIndicatorView.h
//
//  Created by Alexander Givens on 9/2/14.
//  Copyright (c) 2014 Alex Givens. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface AGEqualizerIndicatorView : UIView

/**
Must contain an array of NSNumbers between 0.0 and 1.0. The count of this array determines how many bars will draw.
 */
@property (nonatomic, strong) NSArray *barPositions;

/**
Seed the equalizer view with a beat-per-minute integer to alter animation speeds.
 */
@property (nonatomic, strong) IBInspectable NSNumber *bpm;


@property (nonatomic) IBInspectable NSInteger barSpacing;

- (id)initWithFrame:(CGRect)frame barPositions:(NSArray *)barPositions BPM:(NSNumber *)bpm;

- (void)startAnimated:(BOOL)animated;
- (void)pauseAnimated:(BOOL)animated;
- (void)stopAnimated:(BOOL)animated;

@end
