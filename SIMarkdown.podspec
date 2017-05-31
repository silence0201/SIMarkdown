Pod::Spec.new do |s|
  s.name         = "SIMarkdown"
  s.version      = "0.1.0"
  s.summary      = "Markdown View implement with Objective-C"
  s.homepage     = "https://github.com/silence0201/SIMarkdown"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/silence0201/SIMarkdown.git", :tag => "#{s.version}" }
  s.source_files  = "MarkdownView", "MarkdownView/**/*.{h,m}"
  s.resource  = 'MarkdownView/Markdown.bundle'
  s.requires_arc = true
end
