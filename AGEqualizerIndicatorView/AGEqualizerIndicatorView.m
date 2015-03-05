//
//  AGEqualizerIndicatorView.m
//
//  Created by Alexander Givens on 9/2/14.
//  Copyright (c) 2014 Alex Givens. All rights reserved.
//

#import "AGEqualizerIndicatorView.h"

#define kEqualizerBarPadding 1.5
#define kEqualizerAnimationDuration 0.25

@interface AGEqualizerIndicatorView()

@property (nonatomic, strong) NSArray *barArray;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AGEqualizerIndicatorView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
        [self generateBars];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaultValues];
        [self generateBars];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame barPositions:(NSArray *)barPositions BPM:(NSNumber *)bpm {
    self = [super initWithFrame:frame];
    if (self) {
        _bpm = bpm;
        _barPositions = barPositions;
        [self generateBars];
    }
    return self;
}

- (void)setDefaultValues {
    _bpm = @100;
    _barPositions = @[@0.7,
                      @0.8,
                      @0.3];
}

- (void)setBpm:(NSNumber *)bpm {
    _bpm = [NSNumber numberWithFloat:MIN(160, MAX(60, [bpm floatValue]))];
    // TODO: reset the animation cycle
}

- (void)setBarPositions:(NSArray *)barPositions {
    _barPositions = barPositions;
    // TODO: redraw the bars and reset the animation cycle
}

- (void)generateBars {
    
    NSMutableArray *tempBarArray = [NSMutableArray arrayWithCapacity:self.barPositions.count];
    float barWidth = (self.bounds.size.width - (kEqualizerBarPadding * 3)) / self.barPositions.count;
    
    for (int idx=0; idx < self.barPositions.count; idx++)  {
        
        float barXCoordinate = idx * barWidth + idx * kEqualizerBarPadding;
        CGRect barFrame = CGRectMake(barXCoordinate, 0, barWidth, 0);
        
        UIImageView *barView = [[UIImageView alloc] initWithFrame:barFrame];
        barView.image = [self imageWithColor:self.tintColor size:CGSizeMake(1, 1)];
        
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
    
    for (int idx = 0; idx < self.barPositions.count; idx++) {
        
        UIImageView *barView = [_barArray objectAtIndex:idx];
        NSNumber *pausePosition = [_barPositions objectAtIndex:idx];
        
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

- (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    UIBezierPath* rPath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., size.width, size.height)];
    [color setFill];
    [rPath fill];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#if TARGET_INTERFACE_BUILDER

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, 1.0);
    CGRectInset (myFrame, 1.0, 1.0);
    [self.tintColor set];
    UIRectFrame(myFrame);
    
}

#endif

@end
