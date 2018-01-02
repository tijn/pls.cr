require "../spec_helper"

describe PLS::Playlist do
  it "can be created" do
    playlist = PLS::Playlist.new
    playlist.empty?.should eq(true)
  end
end
