require 'spec_helper'

describe Opawesome::TrackerHelper do
  before do
    helper.stub(:logged_in?){ false }
  end

  describe "#opaw_select" do
    context "when the user doesn't have a valid optimization session cookie" do
      before do
        @cookies = mock permanent: mock
        @cookies.permanent.stub(:[]=)
        @cookies.stub(:[])
        @cookies.stub(:[]).with(:opaw_valid_session) { nil }
        helper.stub(:cookies) { @cookies }
        @option = mock_model Opawesome::TestOption, value: 'test_value', select!: true
        @test = mock_model Opawesome::Test, options: [@test], select_option: @option
        Opawesome::Test.stub(:where){ Opawesome::Test }
        Opawesome::Test.stub(:first_or_initialize){ @test }
      end

      it "should not count the option selection yet" do
        @option.should_not_receive(:select!)
        helper.opaw_select(:test_key, '')
      end
    end

    context "when a user has a tracking key for a test" do
      before do
        @cookies = mock permanent: mock
        @cookies.permanent.stub(:[]=)

        @option = mock_model Opawesome::TestOption, value: 'test_value'
        @cookies.stub(:[]){ @option.id }
        helper.stub(:cookies) { @cookies }
      end

      context "when the test option in the cookie exists" do
        before do
          Opawesome::TestOption.stub(:where) { Opawesome::TestOption }
          Opawesome::TestOption.stub(:first){ @option }
        end

        it "should return the option's value" do
          helper.opaw_select(:test_key, '').should eq(@option.value)
        end
      end

      context "when the test option in the cookie doesn't exist" do
        before do
          Opawesome::TestOption.stub(:where) { Opawesome::TestOption }
          Opawesome::TestOption.stub(:first){ nil }
        end

        it "should clear the cookie" do
          @cookies.should_receive(:[]=).with("opaw_test_key", nil)
          helper.opaw_select(:test_key, '')
        end
      end
    end

    context "when a user doesn't have a tracking key for a test" do
      before do
        @cookies = mock permanent: mock
        @cookies.permanent.stub(:[]=)
        @cookies.stub(:[])
        @cookies.stub(:[]).with(:opaw_valid_session) { true }
        helper.stub(:cookies) { @cookies }
      end

      context "when the test already exists" do
        before do
          @option = mock_model Opawesome::TestOption, value: 'test_value', select!: true
          @test = mock_model Opawesome::Test, options: [@test], select_option: @option
          Opawesome::Test.stub(:where){ Opawesome::Test }
          Opawesome::Test.stub(:first_or_initialize){ @test }
        end

        it "should select an option" do
          @option.should_receive(:select!)
          helper.opaw_select(:test_key, '')
        end

        it "should set the user's tracking cookie for the test" do
          @cookies.permanent.should_receive(:[]=).with("opaw_test_key", @option.id)
          helper.opaw_select(:test_key, '')
        end

        it "should return the option value" do
          helper.opaw_select(:test_key, '').should eq(@option.value)
        end
      end

      context "when the test doesn't exist yet" do
        before do
          @option = mock_model(Opawesome::TestOption, value: 'test_value', select!: true).as_new_record
          @test = mock_model(Opawesome::Test, options: [@test], select_option: @option, key: 'test_key', save!: true).as_new_record
          @test.stub(:name=)
          Opawesome::Test.stub(:where){ Opawesome::Test }
          Opawesome::Test.stub(:first_or_initialize){ @test }
        end

        it "should set a default name based on the test key" do
          @test.should_receive(:name=).with("Test key")
          helper.opaw_select(:test_key, '')
        end

        it "should save the test" do
          @test.should_receive(:save!)
          helper.opaw_select(:test_key, '')
        end

        it "should create a default test option" do
          Opawesome::TestOption.should_receive(:create!).with(hash_including(value: 'testing', test_id: @test.id))
          helper.opaw_select(:test_key, 'testing')
        end
      end
    end

    it "should return the default option when no test exists yet" do
      helper.opaw_select(:key, 'default name').should eq('default name')
    end
  end

  describe "#opaw_convert!" do
    context "when a user has a tracking key for a test" do
      before do
        @cookies = mock permanent: mock
        @cookies.permanent.stub(:[]=)

        @option = mock_model Opawesome::TestOption, value: 'test_value'
        @cookies.stub(:[]){ nil }
        @cookies.stub(:[]).with('opaw_test_key') { @option.id }
        @cookies.stub(:[]).with(:opaw_valid_session) { true }
        helper.stub(:cookies) { @cookies }
      end

      context "when the test option in the cookie exists" do
        before do
          Opawesome::TestOption.stub(:where){ Opawesome::TestOption }
          Opawesome::TestOption.stub(:first){ @option }
        end

        it "should track a conversion" do
          @option.should_receive(:convert!)
          helper.opaw_convert!(:test_key)
        end
      end

      context "when the test option in the cookie doesn't exist" do
        before do
          Opawesome::TestOption.stub(:where){ Opawesome::TestOption }
          Opawesome::TestOption.stub(:first){ nil }
        end

        it "should clear the cookie" do
          @cookies.should_receive(:[]=).with("opaw_test_key", nil)
          helper.opaw_convert!(:test_key)
        end
      end
    end
  end
end
