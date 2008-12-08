Gem::Specification.new do |s|
  # Project
  s.name         = 'future'
  s.summary      = "A naieve implementation of futures"
  s.description  = "A naieve implementation of futures"
  s.version      = '0.1.0'
  s.date         = '2008-12-08'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Wes Oldenbeuving"]
  s.email        = "narnach@gmail.com"
  s.homepage     = "http://www.github.com/Narnach/future"

  # Files
  root_files     = %w[MIT-LICENSE README.rdoc Rakefile future.gemspec]
  bin_files      = %w[]
  lib_files      = %w[future]
  test_files     = %w[]
  spec_files     = %w[]
  s.bindir       = "bin"
  s.require_path = "lib"
  s.executables  = bin_files
  s.test_files   = test_files.map {|f| 'test/%s_test.rb' % f} + spec_files.map {|f| 'spec/%s_spec.rb' % f}
  s.files        = root_files + bin_files.map {|f| 'bin/%s' % f} + lib_files.map {|f| 'lib/%s.rb' % f} + s.test_files

  # rdoc
  s.has_rdoc         = true
  s.extra_rdoc_files = %w[ README.rdoc MIT-LICENSE]
  s.rdoc_options << '--inline-source' << '--line-numbers' << '--main' << 'README.rdoc'

  # Requirements
  s.required_ruby_version = ">= 1.8.0"
end
