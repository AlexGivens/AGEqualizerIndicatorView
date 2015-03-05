//
//  CMEqualizerView.m
//  Color Myx
//
//  Created by Alexander Givens on 9/2/14.
//  Copyright (c) 2014 Jingo. All rights reserved.
//

#import "CMEqualizerView.h"
#import "UIImage+Extensions.h"

#define kEqualizerBarPadding 1.5
#define kEqualizerAnimationDuration 0.25

@interface CMEqualizerView()

@property (nonatomic, strong) NSArray *barArray;
@property (nonatomic, strong) NSArray *pausePositions;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CMEqualizerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bpm = 100;
        [self generateBars];
    }
    return self;
}

- (void)generateBars {
    
    _pausePositions = @[ @0.7,
                         @0.5,
                         @0.8,
                         @0.3 ];
    
    NSMutableArray *tempBarArray = [NSMutableArray arrayWithCapacity:4];
    float barWidth = (self.bounds.size.width - (kEqualizerBarPadding * 3)) / 4;
    
    for (int idx=0; idx < 4; idx++)  {
        
        float barXCoordinate = idx * barWidth + idx * kEqualizerBarPadding;
        CGRect barFrame = CGRectMake(barXCoordinate, 0, barWidth, 0);
        
        UIImageView *barView = [[UIImageView alloc] initWithFrame:barFrame];
        barView.image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
        
        [self addSubview:barView];
        
        [tempBarArray addObject:barView];
    }
    
    _barArray = [NSArray arrayWithArray:tempBarArray];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2*2);
    self.transform = transform;
}

- (void)startAnimated:(BOOL)animated {
    
    if (!animated) [self setAllBarsAtPauseHeights];
    
    if (![_timer isValid]){
        _timer = [NSTimer scheduledTimerWithTimeInterval:kEqualizerAnimationDuration
                                                  target:self
                                                selector:@selector(ticker)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)pauseAnimated:(BOOL)animated {
    [self killTimers];
    
    if (animated) {
        [UIView animateWithDuration:kEqualizerAnimationDuration
                         animations: ^{
                             [self setAllBarsAtPauseHeights];
                         }];
    } else {
        [self setAllBarsAtPauseHeights];
    }
}

- (void)stopAnimated:(BOOL)animated {
    [self killTimers];

    if (animated) {
        [UIView animateWithDuration:kEqualizerAnimationDuration
                         animations: ^{
                             [self setAllBarsAtZero];
                         }];
    } else {
        [self setAllBarsAtZero];
    }
}

- (void)ticker {
    
    [UIView animateWithDuration:kEqualizerAnimationDuration
                     animations:^{
                         
                         for (UIImageView *barView in _barArray) {
                             
                             CGRect rect = barView.frame;
                             int frameHeight = self.frame.size.height;
                             int baselineHeight = frameHeight * 0.2;
                             int modifiedHeight = baselineHeight + (arc4random() % frameHeight * 0.8 + 1);
                             rect.size.height = modifiedHeight;
                             barView.frame = rect;
                             
                         }
                     }];
    
}

- (void)setAllBarsAtZero {
    for (UIImageView *barView in _barArray) {
        CGRect rect = barView.frame;
        rect.size.height = 0;
        barView.frame = rect;
    }
}

- (void)setAllBarsAtPauseHeights {
    
    for (int idx = 0; idx < 4; idx++) {
        
        UIImageView *barView = [_barArray objectAtIndex:idx];
        NSNumber *pausePosition = [_pausePositions objectAtIndex:idx];
        
        CGRect rect = barView.frame;
        rect.size.height = [pausePosition floatValue] * self.bounds.size.height;
        barView.frame = rect;
        
    }
}

- (void)killTimers {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
