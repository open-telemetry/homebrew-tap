class Ocb < Formula
  desc "OpenTelemetry Collector Builder - assemble custom OTel Collector distributions"
  homepage "https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder"
  version "0.166.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_arm64"
      sha256 "b8a68488874d2ad0efb564972c5bf8117c7e0fd89583f181b6a02eb2f15aaf4f"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_darwin_amd64"
      sha256 "acae91c2e48462f7e05cd18634c325920c634154f5977204d78dbad0bcea697d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_arm64"
      sha256 "d0744004b9799bb797b23ef14e4d112e375892e994f72f7f67a2b5b998969362"
    end

    on_intel do
      url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv#{version}/ocb_#{version}_linux_amd64"
      sha256 "3f36e7dd204fd2c541cf1ef67babbb75d40a7bb8236223596717d0a9bcf364b8"
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
