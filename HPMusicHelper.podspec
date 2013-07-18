Pod::Spec.new do |s|
  s.name     = 'HPMusicHelper'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Clean Artist Name, title song'
  s.author   = { 'Herve Peroteau' => 'herve.peroteau@gmail.com' }
  s.description = 'Utils to clean Artist Name, title song'
  s.platform = :ios
  s.source = { :git => "https://github.com/herveperoteau/HPMusicHelper.git"}
  s.source_files = 'HPMusicHelper'
  s.requires_arc = true
end
