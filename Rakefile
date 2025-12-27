require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

task default: :test

def download_package(name, version)
  require "fileutils"
  require "tmpdir"

  puts "Downloading #{name} #{version}"
  Dir.chdir(Dir.mktmpdir) do
    system "npm", "pack", "#{name}@#{version}", "-q", exception: true
    system "tar", "xzf", "#{name}-#{version}.tgz", exception: true

    # vega-lite and vega-embed no longer provide non-minified UMD builds
    suffix = ["vega-lite", "vega-embed"].include?(name) ? ".min" : ""
    contents = File.read("package/build/#{name}#{suffix}.js")
    # remove source map to prevent console warnings
    contents.sub!("//# sourceMappingURL=#{name}#{suffix}.js.map\n", "")
    File.write(File.expand_path("vendor/assets/javascripts/#{name}.js", __dir__), contents)

    FileUtils.cp("package/LICENSE", File.expand_path("licenses/LICENSE-#{name}.txt", __dir__))
  end
end

# update in lib/vega/spec.rb as well
task :update do
  download_package("vega", "6.1.2")
  download_package("vega-lite", "6.2.0")
  download_package("vega-embed", "7.0.2")
  download_package("vega-interpreter", "2.0.0")
end
