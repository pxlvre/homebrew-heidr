class Heidr < Formula
  desc "EVM blockchain CLI tool"
  homepage "https://github.com/pxlvre/heidr"
  url "https://github.com/pxlvre/heidr/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "ab3ae8b071d978e304dc539a561a23fd035da30ed4ad165c9a4e4a38f216615a"
  license "AGPL-3.0-or-later"
  head "https://github.com/pxlvre/heidr.git", branch: "master"

  depends_on "oven-sh/bun/bun"

  def install
    # Install all source files
    libexec.install Dir["*"]
    
    # Install dependencies (ignore prepare scripts to avoid husky)
    cd libexec do
      system "bun", "install", "--frozen-lockfile", "--production", "--ignore-scripts"
    end
    
    # Create wrapper script
    (bin/"heidr").write <<~EOS
      #!/bin/bash
      exec "#{HOMEBREW_PREFIX}/bin/bun" "#{libexec}/cli/index.ts" "$@"
    EOS
  end

  test do
    assert_match "0.0.5", shell_output("#{bin}/heidr --version")
  end
end
