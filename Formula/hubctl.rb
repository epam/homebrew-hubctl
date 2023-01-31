# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hubctl < Formula
  desc "Hub CTL is stack composition and lifecycle tool."
  homepage "https://superhub.io/"
  version "1.0.11"
  license "MPL-2.0"

  depends_on "jq"
  depends_on "yq"
  depends_on "npm" => :optional

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/epam/hubctl/releases/download/v1.0.11/hubctl_Darwin_arm64.tar.gz"
      sha256 "16e3635046bc3c5672d8feaa0ec3efc2c6e61dc6a6fd6deae4bc71fdb5850a4b"

      def install
        bin.install "hubctl"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/epam/hubctl/releases/download/v1.0.11/hubctl_Darwin_x86_64.tar.gz"
      sha256 "db8c03dbdff9fc0665baba2d202a00170cb55c61646503436c558b7949a4adbe"

      def install
        bin.install "hubctl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/epam/hubctl/releases/download/v1.0.11/hubctl_Linux_arm64.tar.gz"
      sha256 "5d5675ddd6d4d0351b09d0fb087b2f1a50dbac021c43344737033932d1121bd9"

      def install
        bin.install "hubctl"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/epam/hubctl/releases/download/v1.0.11/hubctl_Linux_x86_64.tar.gz"
      sha256 "42be28bf9a1e6cd4112e468f337d254ddf8b3b83d7f4f1e60f959d747c1f00b0"

      def install
        bin.install "hubctl"
      end
    end
  end

  head "https://github.com/epam/hubctl"

  def post_install
    hub_home = Pathname.new "#{Dir.home}/.hub"
    unless hub_home.exist?
        system "#{Formula["hub"].opt_bin}/hubctl", "extensions", "install"
    end
  end

  def caveats
    <<~EOS
      hubctl version
      hubctl help
      hubctl elaborate hub.yaml params.yaml -o hub.yaml.elaborate
      hubctl deploy hub.yaml.elaborate -e NAME=stage
    EOS
  end

  test do
    output = shell_output("#{bin}/hubctl version").chomp
    assert output.start_with?("Hub CTL git ")
    system "false"
  end
end
