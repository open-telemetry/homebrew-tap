class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.165.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "cad94cb71afc01d5988cffd8b832f1baaf16877f5fea10d8b2f8c3e0bb489bed"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "3da3cc2017d90dc4b2e991cfe55b3eb2eaf92bad7e6c400e23f9dcb669419eee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "60796ab92c4becb5a2f54da5dff36e8127e69ea42daca4798b711d9b5c0f3002"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "6fd899cf8794803bb0d9ea0a055fdaabd2e7e8304de3872fd9aaec3f0cd7f18c"
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
