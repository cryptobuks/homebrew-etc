require 'formula'

class Geth < Formula
  version '3.0.1'

  homepage 'https://github.com/ethereumproject/go-ethereum'
  url 'https://github.com/ethereumproject/go-ethereum/releases/download/v3.0.1/geth-classic-darwin-65f1fbc.zip'

  bottle do
    revision 2
    url 'https://github.com/ethereumproject/go-ethereum/releases/download/v3.0.1/geth-classic-darwin-65f1fbc.zip'
    sha256 'eeb55964343e2b36695ff61700bc3058c398d4fb948cbe34ced317bddf744b01'
  end

  depends_on 'go' => :build

  def install
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"
    system "go", "env" # Debug env
    system "make", "all"
    bin.install 'build/bin/evm'
    bin.install 'build/bin/geth'
    bin.install 'build/bin/rlpdump'
  end

  test do
    system "make", "test"
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
            <string>#{opt_bin}/geth</string>
            <string>-datadir=#{prefix}/.ethereum</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end
