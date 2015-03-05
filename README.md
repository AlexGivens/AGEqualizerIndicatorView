# AGEqualizerIndicatorView
AGEqualizerIndicatorView is an iOS library used to visually indicate the play, pause, or stop state of audio. AGEqualizerIndicatorView is designable in Interface Builder for quicker mockups.

## Getting Started

- [Download AGEqualizerIndicatorView](https://github.com/alexgivens/AGEqualizerIndicatorView/archive/master.zip) and try the included example project.
- Copy the "AGEqualizerIndicatorView" directory into your project
- Import the header file at the top of your document, like so: ```#import "AGEqualizerIndicatorView.h"```

## Using AGEqualizerIndicatorView

Quick demonstration.

```objective-c
AGEqualizerIndicatorView *equalizerIndicatorView = [[AGEqualizerIndicatorView alloc] initWithFrame: CGRectMake(0,0,16,16)];
[equalizerIndicatorView startAnimated:YES]; // audio begins playing
[equalizerIndicatorView pauseAnimated:YES]; // audio is paused
[equalizerIndicatorView stopAnimated:YES]; // audio ends playback
```

A fuller set of documentation is coming soon, describing how to implement a set of equalizer indicators in a UITableView drawn in a Storyboard.

## Requirements

AGEqualizerIndicatorView is supported on iOS 8.0+ and requires ARC. 

## Credits

AGEqualizerIndicatorView was originally designed and developed by [Alex Givens](http://alexgivens.com) for the [Color Myx](https://itunes.apple.com/us/app/color-myx/id937256071?mt=8) music player. AGEqualizerIndicatorView resides under the [MIT License](https://github.com/AlexGivens/AGEqualizerIndicatorView/blob/master/LICENSE).
