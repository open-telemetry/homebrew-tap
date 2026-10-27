class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.164.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "40b19fc43ce9135cfb12779bcafacf496abfa2377f1f5ff79472037a8761e2b9"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "66630f6020779be8eca7123769867407d197088db7f5de12da82f36001a546e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "1ffdadaf554eccfbabbf42166c9b6bd7db72730702d8cc97b7de7e34968f18fa"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "ce723e9cdd8e39293af49a2cfd11b22f9891401cb6da978db30188ca300a280f"
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
