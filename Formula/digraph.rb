class Digraph < Formula
  desc "Monitor and detect policy violations in infrastructure deploys using Digraph"
  homepage "https://www.getdigraph.com"
  url "https://github.com/di-graph/digraph-cli/archive/refs/tags/v0.0.32.tar.gz"
  sha256 "82defbd4efbcb0175ce7c412e5662fb254d72b87cdeaaa3269d3fd17fd069031"
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
