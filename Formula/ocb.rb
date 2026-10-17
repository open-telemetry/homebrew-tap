class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.163.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "543997ec317883f06f61c9ec228fbc59e086b1f5f011f195478466ab8081e377"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "0a48c7b67242da722e695078940f71f73535dec205a2b5a2e899b9b1cc876880"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "77d909f9745bef67c4aa3c678c3f9e7a703167b8e819b8a819854a3851cd5444"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "3497daf1005f53c2a2da171ecafb9e1defb1ed0373b5d44d0ba8e1ba6bd3a0c1"
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
    assert_match version.to_s, shell_output("#{bin}/ocb version 2>&1")
  end
end
