Pod::Spec.new do |s|
  s.name = "SIMarkdown"
  s.version = "1.0.1"
  s.summary = "Markdown View implement with Objective-C"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Silence"=>"374619540@qq.com"}
  s.homepage = "https://github.com/silence0201/SIMarkdown"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/SIMarkdown.framework'
end
