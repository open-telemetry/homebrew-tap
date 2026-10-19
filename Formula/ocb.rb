class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.162.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "75d49e2c9abe5454856901d34b9a0935a87256e4e8cb8063a5760a7b3f72fb18"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "bc76dfa4625c438a371eb92cdc877ca0d3be9a76ceb37f9f2a68638b35e99171"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "d0a5e82e501e4ef45dc454630384d6caa90ce7f5d977b745911ad4cb81ec8069"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "7c74640d726f23689d8853e0d5a55707ad8b524417ca7416c036c4ecb9ddb01f"
    end
  end

  livecheck do
    url :stable
    regex(%r{^cmd/builder/v(\d+(?:\.\d+)+)$}i)
    strategy :github_releases
  end

  def install
    # The upstream binary is already named `ocb`, so we just install it directly.
    bin.install stable.url.split("/").last => "ocb"
  end

  test do
    # Releases-repo-only patches (e.g. 0.163.1) are built from the collector core
    # release (v0.163.0), whose binary reports `<major>.<minor>.0+dirty`. A patch
    # coming from ocb itself reports its own version.
    expected = [
      "v#{version.major_minor}.0+dirty",
      "v#{version}",
    ].map { |v| Regexp.escape(v) }
    assert_match(/\Aocb version (#{expected.join("|")})\n\z/, shell_output("#{bin}/ocb version 2>&1"))
  end
end
