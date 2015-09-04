Pod::Spec.new do |s|
    s.name                  = "AGEqualizerIndicatorView"
    s.version               = "1.0"
    s.summary               = "Indicator used to represent the play/pause/stop state of audio."
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.homepage              = "http://alexgivens.com"
    s.author                = { "Alex Givens" => "mail@alexgivens.com" }
    s.source                = { :git => "https://github.com/AlexGivens/AGEqualizerIndicatorView.git", :tag => s.version}
    s.source_files          = 'AGEqualizerIndicatorView/AGEqualizerIndicatorView.{h,m}'
    s.public_header_files   = 'AGEqualizerIndicatorView/*.h'
    s.requires_arc          = true
    s.ios.deployment_target = '7.0'
end