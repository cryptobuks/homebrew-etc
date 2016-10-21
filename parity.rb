require 'formula'

class Parity < Formula
  homepage 'https://github.com/ethcore/parity'

  if build.include? "master"
    version '1.4.0'
    url 'https://github.com/ethcore/parity.git', :branch => 'master', :using => :git
  elsif build.include? "beta"
    version '1.3.9'
    url 'https://github.com/ethcore/parity.git', :tag => 'v1.3.9', :using => :git
  else
    version '1.3.9'
    url 'https://github.com/ethcore/parity.git', :tag => 'v1.3.9', :using => :git
  end

  depends_on 'multirust' => :build

  option 'master', 'Build and install nightly version.'
  option 'beta', 'Build and install latest beta. '
  option 'stable', 'Install latest stable (default).'

  option 'geth-compatible', 'Run service with --geth option.'

  def install
    system "multirust update stable"
    system "multirust run stable cargo build --release"
    bin.install "target/release/parity"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ThrottleInterval</key>
        <integer>300</integer>
        <key>ProgramArguments</key>
        <array>
          <string>#{prefix}/bin/parity</string>
          <string>--chain=classic</string>
          #{'<string>--geth</string>' if build.include? 'geth-compatible'}
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end
