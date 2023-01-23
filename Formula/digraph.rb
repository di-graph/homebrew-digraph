class Digraph < Formula
  desc "Monitor and detect policy violations in infrastructure deploys using Digraph"
  homepage "https://www.getdigraph.com"
  url "https://github.com/di-graph/digraph-cli/archive/refs/tags/v0.0.24.tar.gz"
  sha256 "819c185420aa304ed5b10ac6114aba142ba81f804837bd90e0bb26b0ec24f0ca"
  license "MIT"
  head "https://github.com/di-graph/digraph-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/di-graph/digraph"
    bin_path.install Dir["*"]
    cd bin_path do
    system "go", "build", "-o", bin/"digraph", "."
    end
  end

  test do
    output = shell_output("#{bin}/digraph validate 2>&1", 1)
    assert_match "Error: must specify api-key as argument or set it within a .env file", output
  end
end
