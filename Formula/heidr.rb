class Heidr < Formula
  desc "EVM blockchain CLI tool"
  homepage "https://github.com/pxlvre/heidr"
  url "https://github.com/pxlvre/heidr/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "49195dc96e04c13afe41619ca278470dfbd9753d7f0d0f831f96c18ea548045d"
  license "AGPL-3.0-or-later"
  head "https://github.com/pxlvre/heidr.git", branch: "master"

  depends_on "oven-sh/bun/bun"

  def install
    # Install all source files
    libexec.install Dir["*"]
    
    # Install dependencies
    cd libexec do
      system "bun", "install", "--frozen-lockfile", "--production"
    end
    
    # Create wrapper script
    (bin/"heidr").write <<~EOS
      #!/bin/bash
      exec "#{HOMEBREW_PREFIX}/bin/bun" "#{libexec}/cli/index.ts" "$@"
    EOS
  end

  test do
    assert_match "0.0.3", shell_output("#{bin}/heidr --version")
  end
end
