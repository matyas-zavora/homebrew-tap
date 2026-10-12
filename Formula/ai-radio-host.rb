class AiRadioHost < Formula
  desc "Personal AI radio host that talks between your Spotify songs"
  homepage "https://github.com/matyas-zavora/ai-radio-host"
  url "https://github.com/matyas-zavora/ai-radio-host/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0b90a7ed0ebc6e30ebf1bead3105d2ec1f00937856a1b68352c9c4674fa166ee"
  license "MIT"
  head "https://github.com/matyas-zavora/ai-radio-host.git", branch: "main"

  depends_on "librsvg" => :build
  depends_on "gtk4"
  depends_on "libadwaita"
  depends_on :macos
  depends_on "pygobject3"
  depends_on "python@3.14"

  # Prebuilt PyPI wheels (jiter, onnxruntime) have @rpath IDs without room to rewrite them.
  preserve_rpath

  def install
    # PyGObject comes from Homebrew (--system-site-packages); everything else from PyPI.
    system formula_opt_bin("python@3.14")/"python3.14", "-m", "venv", "--system-site-packages", libexec
    system libexec/"bin/pip", "install", "--quiet", "--no-cache-dir", "#{buildpath}[piper,google]"
    bin.install_symlink libexec/"bin/radiohost", libexec/"bin/radiohost-gui"
    # The app points at opt_libexec, so a copy in /Applications keeps working after upgrades.
    system "macos/build-app.sh", opt_libexec, prefix/"AI Radio Host.app", version.to_s
  end

  def caveats
    <<~EOS
      To get AI Radio Host in Launchpad, Spotlight and the Dock, copy the app once:
        cp -R "#{opt_prefix}/AI Radio Host.app" /Applications/
      It keeps working after `brew upgrade`; there's no need to copy it again.

      On first launch a setup wizard connects Spotify, the AI and the voice.
      Settings live in ~/.config/ai-radio-host/.
    EOS
  end

  test do
    assert_match "AI radio host", shell_output("#{bin}/radiohost --help")
  end
end
