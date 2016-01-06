Pod::Spec.new do |s|
  s.name             = "NSUnderscore"
  s.version          = "0.1.0"
  s.summary          = "NSUnderscore is a re-implementation of the key helper functions available in Underscore.js."
  s.description      = <<-DESC
                       NSUnderscore is a set of categories added to NSArray, NSDictionary, and NSSet. This project is an attempt to bring some of the useful functionality found in Underscore.js to the world of iOS programming. Not every single function has been ported over, as some functions are already implemented on the collection objects.
                       DESC

  s.homepage         = "https://github.com/rgerard/NSUnderscore"
  s.license          = 'MIT'
  s.author           = { "rgerard" => "ryan.gerard@gmail.com" }
  s.source           = { :git => "https://github.com/rgerard/NSUnderscore.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dreadpirateryan'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'NSUnderscore/**/*'
end
