Gem::Specification.new do |spec|

  spec.name = 'capigento'
  spec.version = '0.1.6'
  spec.platform = Gem::Platform::RUBY
  spec.description = <<-DESC
    Deployment recipe for magento applications.
  DESC
  spec.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Deploying Magento PHP applications with Capistrano.
  DESC

  spec.files = Dir.glob("{bin,lib}/**/*") + %w(README.md CHANGELOG)
  spec.require_path = 'lib'
  spec.has_rdoc = false

  spec.bindir = "bin"
  spec.executables << "capigento"

  spec.add_dependency 'capistrano', ">= 2.5.10"

  spec.author = "Witold Janusik"
  spec.email = "me@freakphp.com"
  spec.homepage = "http://capigento.hatimeria.com"
  spec.rubyforge_project = "capigento"

end
