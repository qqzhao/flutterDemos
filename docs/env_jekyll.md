

### Installing Nokogiri

错误提示：
```
An error occurred while installing nokogiri (1.5.2), and bundle cannot continue.
Make sure that 'gem install nokogiri -v 1.5.2 succeed before building.


IMPORTANT NOTICE:

Building Nokogiri with a packaged version of libxml2-2.9.5.

Team Nokogiri will keep on doing their best to provide security
updates in a timely manner, but if this is a concern for you and want
to use the system library instead; abort this installation process and
reinstall nokogiri as follows:

    gem install nokogiri -- --use-system-libraries
        [--with-xml2-config=/path/to/xml2-config]
        [--with-xslt-config=/path/to/xslt-config]

If you are using Bundler, tell it to use the option:

    bundle config build.nokogiri --use-system-libraries
    bundle install

Note, however, that nokogiri is not fully compatible with arbitrary
versions of libxml2 provided by OS/package vendors.
```

** 原因是与libxml2不兼容。

mac 安装方式：
```
brew unlink xz
gem install nokogiri # or bundle install
brew link xz

brew install libxml2
# If installing directly
gem install nokogiri -- --use-system-libraries \
  --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
# If using Bundle
bundle config build.nokogiri --use-system-libraries \
  --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
bundle install
```

[Installing Nokogiri](http://www.nokogiri.org/tutorials/installing_nokogiri.html)

### 安装成功后，Jekyll - command not found

```
bundle update // 不起作用
cd /usr/bin && ln -s /usr/local/Cellar/ruby/1.9.3-p194/lib/ruby/gems/1.9.1/gems/jekyll-1.4.3/bin/jekyll jekyll
```

[Jekyll on Heroku: bundler: command not found: thin](https://stackoverflow.com/questions/14597407/jekyll-on-heroku-bundler-command-not-found-thin)
[jekyll-command-not-found](https://stackoverflow.com/questions/8146249/jekyll-command-not-found)