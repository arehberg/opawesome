require 'spec_helper'

describe Opawesome::TestOption do
  it { should belong_to :test }

  describe "statistics" do
    it "should return a conversion rate" do
      Opawesome::TestOption.new(conversion_count: 10, selection_count: 20).conversion_rate.should eq(50.0)
    end

    it "should return zero conversion rate if there are no conversions or selections" do
      Opawesome::TestOption.new(conversion_count: 0, selection_count: 20).conversion_rate.should eq(0)
      Opawesome::TestOption.new(conversion_count: 10, selection_count: 0).conversion_rate.should eq(0)
    end
  end

  describe "tracking" do
    before do
      @option = Opawesome::TestOption.new(conversion_count: 0, selection_count: 0)
      @option.should_receive(:save!)
    end

    it "should increment the selection count when selected" do
      proc { @option.select! }.should change(@option, :selection_count).by(1)
    end

    it "should increment the conversion count when converted" do
      proc { @option.convert! }.should change(@option, :conversion_count).by(1)
    end
  end
end
