class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.163.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "5bb9e985f7dc4b8eec4b2555e5ded996fbceda04c07b36b7710b5876b873e61f"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "3478afaf5eb3d00da6abe6a62f36aaab8e49195686369fa641183427b470f2ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "d8c9453a5eb95131441eca1678cb3e925d12e8a14848ceb19b7c0f41e973caf3"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "2aea100793a07cdf396972ca6ab3b137163367399045a2052bd89ba92362a4d5"
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
