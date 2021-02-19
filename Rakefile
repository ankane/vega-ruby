require "bundler/gem_tasks"
require "rake/testtask"
require "fileutils"
require "tmpdir"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

def download_package(name, version)
  puts "Downloading #{name} #{version}"
  Dir.chdir(Dir.mktmpdir) do
    system "npm", "pack", "#{name}@#{version}", "-q"
    system "tar", "xzf", "#{name}-#{version}.tgz"
    FileUtils.cp("package/build/#{name}.js", File.expand_path("vendor/assets/javascripts/#{name}.js", __dir__))
    FileUtils.cp("package/LICENSE", File.expand_path("licenses/LICENSE-#{name}.txt", __dir__))
  end
end

task :update do
  # update in lib/vega/spec.rb and README.md as well
  download_package("vega", "5.19.1")
  download_package("vega-lite", "4.17.0")
  download_package("vega-embed", "6.15.1")
  download_package("vega-interpreter", "1.0.4")
end
