require "formula"

VERSION = '0.2.0'
class TailwindcssPalette < Formula
  desc "Generate Tailwind CSS color palettes from a base hex color"
  homepage "https://github.com/claytonchew/tailwindcss-palette-go"
  url "https://github.com/claytonchew/tailwindcss-palette-go.git", tag: "v#{VERSION}"
  version VERSION
  license "MIT"
  head "https://github.com/claytonchew/tailwindcss-palette-go.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build",
           "-ldflags",
           "-s -w -X github.com/claytonchew/tailwindcss-palette-go/internal/version.Version=#{version} -X github.com/claytonchew/tailwindcss-palette-go/internal/version.CommitHash=#{Utils.git_short_head || "unknown"} -X github.com/claytonchew/tailwindcss-palette-go/internal/version.BuildDate=#{Time.now.utc.iso8601}",
           "-o", "tailwindcss-palette",
           "./cmd/tailwindcss-palette"
    bin.install "tailwindcss-palette"
  end

  test do
    system "#{bin}/tailwindcss-palette", "-v"
  end
end
