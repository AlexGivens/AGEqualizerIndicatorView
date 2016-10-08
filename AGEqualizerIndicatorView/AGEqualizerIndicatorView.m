// AGEqualizerIndicatorView.m
//
// Copyright (c) 2015 Alex Givens (http://alexgivens.com/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AGEqualizerIndicatorView.h"

#define kBarImageViewKey            @"barImageViewKey"
#define kBarAnimationDurationKey    @"barAnimationDurationKey"

#define kEqualizerMinNumBars        @1
#define kEqualizerMaxNumBars        @6
#define kEqualizerMinBPM            @60
#define kEqualizerMaxBPM            @160
#define kEqualizerMinBarSpacing     @1
#define kEqualizerMaxBarSpacing     @5

#define ARC4RANDOM_MAX 0x100000000

@implementation AGEqualizerIndicatorView {
    NSArray *defaultBarAnimationDurations;
    NSMutableArray *bars;
    CGFloat pauseHeight;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self generateBars];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
        [self generateBars];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame numberOfBars:(NSInteger)numberOfBars barSpacing:(NSInteger)barSpacing BPM:(NSInteger)bpm {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        _numberOfBars = MIN([kEqualizerMaxNumBars integerValue], MAX([kEqualizerMinNumBars integerValue], numberOfBars));
        _barSpacing = MIN([kEqualizerMaxBarSpacing floatValue], MAX([kEqualizerMinBarSpacing floatValue], barSpacing));
        _bpm = MIN([kEqualizerMaxBPM integerValue], MAX([kEqualizerMinBPM integerValue], bpm));
        [self generateBars];
    }
    return self;
}

- (void)initialize {
    
    NSMutableArray *tempDefaultBarAnimationDurations = [NSMutableArray arrayWithCapacity:6];
    for (int idx=0; idx < 6; idx++) {
        double randomDuration = ((double)arc4random() / ARC4RANDOM_MAX) * (1.1 - 0.7) + 0.7;
        [tempDefaultBarAnimationDurations addObject:[NSNumber numberWithDouble:randomDuration]];
    }
    defaultBarAnimationDurations = [NSArray arrayWithArray:tempDefaultBarAnimationDurations];
    
    _numberOfBars = 3;
    _barSpacing = 1;
    _bpm = 100;
}

#pragma mark - Property Setter Overrides

- (void)setNumberOfBars:(NSInteger)numberOfBars {
    if (numberOfBars == _numberOfBars) return;
    _numberOfBars = MIN([kEqualizerMaxNumBars integerValue], MAX([kEqualizerMinNumBars integerValue], numberOfBars));
    [self generateBars];
}

- (void)setBarSpacing:(CGFloat)barSpacing {
    if (barSpacing == _barSpacing) return;
    _barSpacing = MIN([kEqualizerMaxBarSpacing floatValue], MAX([kEqualizerMinBarSpacing floatValue], barSpacing));
    [self generateBars];
}

- (void)setBpm:(NSInteger)bpm {
    if (bpm == _bpm) return;
    _bpm = MIN([kEqualizerMaxBPM integerValue], MAX([kEqualizerMinBPM integerValue], bpm));
    [self generateBars];
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    [self generateBars];
}

#pragma mark - Bar Generation

- (void)generateBars {
    
    if (bars) [self removeAllBars];
    
    [self layoutIfNeeded];
    
    bars = [NSMutableArray arrayWithCapacity:_numberOfBars];
    float cumulativeSpacing = _barSpacing * (_numberOfBars - 1);
    float barWidth = (self.bounds.size.width - cumulativeSpacing) / _numberOfBars;
    
    for (int idx=0; idx < _numberOfBars; idx++)  {
        
        float barXCoordinate = (idx * barWidth) + (idx * _barSpacing);
        CGRect barFrame = CGRectMake(barXCoordinate, 0, barWidth, 0);
        
        UIImageView *barImageView = [[UIImageView alloc] initWithFrame:barFrame];
        barImageView.image = [self imageWithColor:self.tintColor size:CGSizeMake(1, 1)];
        
        [self addSubview:barImageView];
        NSDictionary *barDict = @{kBarImageViewKey:barImageView,
                                  kBarAnimationDurationKey: [defaultBarAnimationDurations objectAtIndex:idx]};
        [bars addObject:barDict];
    }
    
    self.transform = CGAffineTransformMakeRotation(M_PI_2*2);
    
    pauseHeight = self.bounds.size.height / 3.5;
}

#pragma mark - Animation methods

- (void)playAnimated:(BOOL)animated {
    
    for (NSDictionary *barDict in bars) {
        
        UIImageView *barImageView = [barDict objectForKey:kBarImageViewKey];
        NSNumber *barAnimationDuration = [barDict objectForKey:kBarAnimationDurationKey];
        NSTimeInterval duration = [barAnimationDuration doubleValue];
        double randomDelay = ((double)arc4random() / ARC4RANDOM_MAX) * (0.2);
        
        [UIView animateKeyframesWithDuration:duration
                                       delay:randomDelay
                                     options: 0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0.0
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        [self setBar:barImageView atHeight:self.bounds.size.height];
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.5
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        [self setBar:barImageView atHeight:pauseHeight];
                                                                    }];
                                  } completion:^(BOOL finished) {
                                      [UIView animateKeyframesWithDuration:duration
                                                                     delay:randomDelay
                                                                   options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat
                                                                animations:^{
                                                                    [UIView addKeyframeWithRelativeStartTime:0.0
                                                                                            relativeDuration:0.5
                                                                                                  animations:^{
                                                                                                      [self setBar:barImageView atHeight:self.bounds.size.height];
                                                                                                  }];
                                                                    [UIView addKeyframeWithRelativeStartTime:0.5
                                                                                            relativeDuration:0.5
                                                                                                  animations:^{
                                                                                                      [self setBar:barImageView atHeight:pauseHeight];
                                                                                                  }];
                                                                } completion:nil];
                                  }];
    }
}

- (void)pauseAnimated:(BOOL)animated {
    [self removeAllBarAnimations];
    
    if (animated) {
        [UIView animateWithDuration:0.25
                         animations: ^{
                             [self setAllBarsAtHeight:pauseHeight];
                         }];
    } else {
        [self setAllBarsAtHeight:pauseHeight];
    }
}

- (void)stopAnimated:(BOOL)animated {
    [self removeAllBarAnimations];
    
    if (animated) {
        [UIView animateWithDuration:0.25
                         animations: ^{
                             [self setAllBarsAtHeight:0.0];
                         }];
    } else {
        [self setAllBarsAtHeight:0.0];
    }
}

#pragma mark - Utility Methods

- (void)setAllBarsAtHeight:(NSInteger)height {
    for (NSDictionary *barDict in bars) {
        UIImageView *barImageView = [barDict objectForKey:kBarImageViewKey];
        [self setBar:barImageView atHeight:height];
    }
}

- (void)setBar:(UIImageView *)bar atHeight:(NSInteger)height {
    CGRect frame = bar.frame;
    frame.size.height = height;
    bar.frame = frame;
}

- (void)removeAllBarAnimations {
    for (NSDictionary *barDict in bars) {
        UIImageView *barImageView = [barDict objectForKey:kBarImageViewKey];
        if (!CGRectEqualToRect([barImageView.layer.presentationLayer frame], CGRectZero)) {
            barImageView.frame = [[barImageView.layer presentationLayer] frame];
        }
        [barImageView.layer removeAllAnimations];
    }
}

- (void)removeAllBars {
    [self removeAllBarAnimations];
    for (NSDictionary *barDict in bars) {
        UIImageView *barImageView = [barDict objectForKey:kBarImageViewKey];
        [barImageView removeFromSuperview];
        barImageView = nil;
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
    [super drawRect:rect];
    
    float cumulativeSpacing = _barSpacing * (_numberOfBars - 1);
    float barWidth = (self.bounds.size.width - cumulativeSpacing) / _numberOfBars;
    float tempPauseHeight = self.bounds.size.height / 3.5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    
    for (int idx=0; idx < _numberOfBars; idx++)  {
        float randomHeight = ((double)arc4random() / ARC4RANDOM_MAX) * (self.bounds.size.height - tempPauseHeight) + tempPauseHeight;
        float barXCoordinate = (idx * barWidth) + (idx * _barSpacing);
        CGRect rectangle = CGRectMake(barXCoordinate, 0, barWidth, randomHeight);
        CGContextFillRect(context, rectangle);
    }
}
#endif

@end
