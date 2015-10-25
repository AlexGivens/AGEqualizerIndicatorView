# AGEqualizerIndicatorView
AGEqualizerIndicatorView visually indicates the play, pause, or stop state of audio. AGEqualizerIndicatorView is designable in Interface Builder for easy configuration and prototyping.

## Installation

### CocoaPods

The recommended method of installation is through [CocoaPods](http://cocoapods.org). Add the following to your Podfile.

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

AGEqualizerIndicatorView currently supports iOS 7.0+ and tvOS 9.0+. **If you're looking for an OS X-compatible fork, check out [CMEqualizerIndicatorView](https://github.com/connor/CMEqualizerIndicatorView).** :hand:

## About

AGEqualizerIndicatorView is created and maintained by [Alex Givens](https://github.com/AlexGivens).

AGEqualizerIndicatorView is released under the MIT license. See LICENSE for details.
