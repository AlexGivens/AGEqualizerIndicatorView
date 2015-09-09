# AGEqualizerIndicatorView
AGEqualizerIndicatorView is an iOS library used to visually indicate the play, pause, or stop state of audio. AGEqualizerIndicatorView is also designable in Interface Builder for easy configuration and prototyping.

## Installation

### CocoaPods

The recommended method of installation is through [CocoaPods](http://cocoapods.org). Add the following line to your Podfile, then run `pod install`.

#### Podfile

```ruby
pod 'AGEqualizerIndicatorView', :git => 'https://github.com/AlexGivens/AGEqualizerIndicatorView.git'
```

### Manual Installation

1. [Download AGEqualizerIndicatorView](https://github.com/alexgivens/AGEqualizerIndicatorView/archive/master.zip)
2. Drag the `AGEqualizerIndicatorView` directory into your Xcode project, and ensure the files are copied into your project's directory.

## Basic Example

AGEqualizerIndicatorView is simple to use, and can easily mimic the state of audio playback.

```objective-c
#import "AGEqualizerIndicatorView.h"

...

AGEqualizerIndicatorView *equalizerIndicatorView = [[AGEqualizerIndicatorView alloc] initWithFrame: CGRectMake(0,0,24,18)];

[equalizerIndicatorView startAnimated:YES]; // audio begins playing
[equalizerIndicatorView pauseAnimated:YES]; // audio is paused
[equalizerIndicatorView stopAnimated:YES]; // audio ends playback
```

## Example Project

An example project is included to showcase the equalizer indicator in a storyboard.

## Device Support

AGEqualizerIndicatorView currenlty supports iOS 7.0+. **If you're looking for an OS X-compatible fork, check out [CMEqualizerIndicatorView](https://github.com/connor/CMEqualizerIndicatorView).** :hand:

## About

AGEqualizerIndicatorView is created and maintained by [Alex Givens](https://github.com/AlexGivens). 

AGEqualizerIndicatorView is released under the MIT license. See LICENSE for details.
