class Vpv < Formula
  desc "Image viewer for image processing experts"
  homepage "https://github.com/kidanger/vpv"
  url "https://github.com/kidanger/vpv/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "b940ec305f019bd13adecc0df32f0168e423b8da15c486062130bd04ffe5e417"
  license "GPL-3.0-only"
  head "https://github.com/kidanger/vpv.git", branch: "dev"

  depends_on "cmake" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "sdl2"

  args = %w[
    -DUSE_OCTAVE=OFF
    -DUSE_EXR=OFF
    -DUSE_LIBRAW=OFF
    -DUSE_GDAL=ON
  ]

  # uncomment for octave support:
  #depends_on "octave"
  #args << "-DUSE_OCTAVE=ON"

  # uncomment for gdal support:
  #depends_on "gdal"
  #args << "-DUSE_GDAL=ON"

  # uncomment for additional features:
  #depends_on "rust" => :build

  on_linux do
    depends_on "mesa"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # vpv is a GUI application; verify it was installed and responds to --help
    assert_match version.to_s, shell_output("#{bin}/vpv --help 2>&1", 1)
  end
end
