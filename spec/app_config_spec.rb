require "spec_helper"

describe AppConfig do
  it "has a version number" do
    expect(AppConfig::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
