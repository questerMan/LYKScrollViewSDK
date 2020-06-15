Pod::Spec.new do |s|

  s.name        = "LYKScrollViewSDK"

  s.version      = "1.0.0."

  s.summary      = "short description of qthTest."

  s.homepage    = "https://github.com/questerMan/LYKScrollViewSDK"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author            = { "questerMan" => "luyikun01@163.com" }

  s.platform    = :ios, "8.0"

  s.source      = { :git => "https://github.com/questerMan/LYKScrollViewSDK.git", :tag => "#{s.version}" }

  s.source_files  = "LYKScrollViewSDK/*.swift"

  s.swift_version = "5.0"

end
