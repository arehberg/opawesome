require 'spec_helper'

describe Opawesome::Test do
  it { should have_many(:options) }

  it { should validate_presence_of(:key) }
  it { should validate_uniqueness_of(:key) }

  describe "statistics" do
    before do
      @test = Opawesome::Test.new
      @test.options << mock_model(Opawesome::TestOption, conversion_count: 8, selection_count: 10)
      @test.options << mock_model(Opawesome::TestOption, conversion_count: 2, selection_count: 15)
    end

    it "should return the conversion count" do
      @test.conversion_count.should eq(10)
    end

    it "should return the selection count" do
      @test.selection_count.should eq(25)
    end
  end

  describe "test options" do
    before do
      @test = Opawesome::Test.new
      @option1 = mock_model(Opawesome::TestOption, conversion_count: 8, selection_count: 10, conversion_rate: 8.0/10 * 100)
      @option2 = mock_model(Opawesome::TestOption, conversion_count: 2, selection_count: 15, conversion_rate: 2.0/15 * 100)
      @test.options = [@option1, @option2]
    end

    it "should return the best option" do
      @test.best_option.should eq(@option1)
    end

    it "should select an option" do
      @test.select_option.should be_a_kind_of(Opawesome::TestOption)
    end
  end
end
