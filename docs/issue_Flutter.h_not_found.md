
### 1. "Flutter/Flutter.h not found." on iOS


早期的flutter版本会出现上面的报错。原因大体如下：
>I am able to reproduce the error consistently using Cocoapods 1.5.0 (newly released) and freshly created Flutter projects (from Flutter master).
It appears Cocoapods 1.5.0 deals differently with symlinks than some earlier versions, leading to a situation where the Flutter pod is effectively empty inside the Xcode project.
The fix of #16273 appears to solve the problem. You can make this change manually to the ios/Podfile in your existing project, then delete ios/Podfile.lock and ios/Pods/.
I have tested that the changed Podfiles work with both Cocoapods 1.4.0 and Cocoapods 1.5.0. I have so far been unable to reproduce the issue with the former.

翻译：Cocoapods 1.5版本的符号链接和早期的版本不同。早期的Podfile文件是在1.4版本上生成的。使用1.5版本配合着原始的Podfile会有问题。目前这个问题已经修复，使用新的Podfile模板：

```
# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

def parse_KV_file(file, separator='=')
  file_abs_path = File.expand_path(file)
  if !File.exists? file_abs_path
    return [];
  end
  pods_ary = []
  skip_line_start_symbols = ["#", "/"]
  File.foreach(file_abs_path) { |line|
      next if skip_line_start_symbols.any? { |symbol| line =~ /^\s*#{symbol}/ }
      plugin = line.split(pattern=separator)
      if plugin.length == 2
        podname = plugin[0].strip()
        path = plugin[1].strip()
        podpath = File.expand_path("#{path}", file_abs_path)
        pods_ary.push({:name => podname, :path => podpath});
      else
        puts "Invalid plugin specification: #{line}"
      end
  }
  return pods_ary
end

target 'Runner' do
  # Prepare symlinks folder. We use symlinks to avoid having Podfile.lock
  # referring to absolute paths on developers' machines.
  system('rm -rf Pods/.symlinks')
  system('mkdir -p Pods/.symlinks/plugins')

  # Flutter Pods
  generated_xcode_build_settings = parse_KV_file('./Flutter/Generated.xcconfig')
  if generated_xcode_build_settings.empty?
    puts "Generated.xcconfig must exist. If you're running pod install manually, make sure flutter packages get is executed first."
  end
  generated_xcode_build_settings.map { |p|
    if p[:name] == 'FLUTTER_FRAMEWORK_DIR'
      symlink = File.join('Pods', '.symlinks', 'flutter')
      File.symlink(File.dirname(p[:path]), symlink)
      pod 'Flutter', :path => File.join(symlink, File.basename(p[:path]))
    end
  }

  # Plugin Pods
  plugin_pods = parse_KV_file('../.flutter-plugins')
  plugin_pods.map { |p|
    symlink = File.join('Pods', '.symlinks', 'plugins', p[:name])
    File.symlink(p[:path], symlink)
    pod p[:name], :path => File.join(symlink, 'ios')
  }
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

```

[github commit history](https://github.com/flutter/flutter/pull/16273/commits/26e8b0e8a44e19bf2f9a339a88135845e028cc49)

[原始git issue](https://github.com/flutter/flutter/issues/16036)