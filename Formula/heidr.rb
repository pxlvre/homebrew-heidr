class Heidr < Formula
  desc "EVM blockchain CLI tool"
  homepage "https://github.com/pxlvre/heidr"
  url "https://github.com/pxlvre/heidr/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "6e896603b28ab85fc9cf4daa500a2d4c45126e4c7ed2f56f63625a7f4ee6fc4d"
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
