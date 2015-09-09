// AGEqualizerIndicatorView.h
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

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface AGEqualizerIndicatorView : UIView

/**
 The number of bars to draw in the equalizer. Minimum of 1 and maximum of 6. Defaults to 3.
 */
@property (nonatomic) IBInspectable NSInteger numberOfBars;

/**
 Spacing between each animating bar. Minimum of 1 and maximum of 5. Defaults to 1.
 */
@property (nonatomic) IBInspectable CGFloat barSpacing;

/**
 Seed the equalizer view with a beat-per-minute integer to alter animation speeds. Minimum of 60 and maximum of 160. Defaults to 100. Note this property has not yet been implemented.
 */
@property (nonatomic) IBInspectable NSInteger bpm;

/**
 * Begin the equalizer bouncing animation.
 *
 * @param animated Optionally animate into position.
 */
- (id)initWithFrame:(CGRect)frame numberOfBars:(NSInteger)numberOfBars barSpacing:(NSInteger)barSpacing BPM:(NSInteger)bpm;

/**
 * Begin the equalizer bouncing animation.
 *
 * @param animated Optionally animate into position.
 */
- (void)startAnimated:(BOOL)animated;

/**
 * Pause the equalizer bouncing animation.
 *
 * @param animated Optionally animate into position.
 */
- (void)pauseAnimated:(BOOL)animated;

/**
 * Stop the equalizer bouncing animation.
 *
 * @param animated Optionally animate into position.
 */
- (void)stopAnimated:(BOOL)animated;

@end
