class Heidr < Formula
  desc "EVM blockchain CLI tool"
  homepage "https://github.com/pxlvre/heidr"
  url "https://github.com/pxlvre/heidr/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "18eec39a39999daf734bc600ef0ac16c600492f381c074c59c0becf95e1d763b"
  license "AGPL-3.0-or-later"
  head "https://github.com/pxlvre/heidr.git", branch: "master"

  depends_on "bun"

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
      exec "#{Formula["bun"].opt_bin}/bun" "#{libexec}/cli/index.ts" "$@"
    EOS
  end

  test do
    assert_match "0.0.3", shell_output("#{bin}/heidr --version")
  end
end
