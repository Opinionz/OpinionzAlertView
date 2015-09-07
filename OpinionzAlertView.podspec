Pod::Spec.new do |s|
    s.name             = "OpinionzAlertView"
    s.version          = "0.1.0"
    s.summary          = "OpinionzAlertView: Beautiful customizable alert view with blocks (and delegate)"
    s.description      = <<-DESC
    Beautiful customizable alert view with blocks. Choose from predefined icons for info, warning, success and error alerts. Customize color or set your desired image.
    DESC

    s.homepage         = "https://opinionz.github.io/OpinionzAlertView"
    # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
    s.license          = 'MIT'
    s.author           = { "Armen" => "armen.mkrtchian@gmail.com", "Tolik" => "tolik.petrosyants@gmail.com" }
    s.source           = { :git => "https://github.com/Opinionz/OpinionzAlertView.git", :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.platform     = :ios, '7.0'
    s.requires_arc = true

    s.source_files = 'OpinionzAlertView/Classes/*.{h,m}'
#    s.resource_bundles = {
#       'OpinionzAlertView' => ['OpinionzAlertView/Assets/Images/*.png']
#   }

    s.resource_bundle = { 'OpinionzAlertView' => 'OpinionzAlertView/Assets/Images/*.png' }
    # s.public_header_files = 'OpinionzAlertView/Classes/**/*.h'
end
