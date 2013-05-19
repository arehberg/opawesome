require 'spec_helper'

describe Opawesome::SessionsController do
  describe "POST 'create'" do
    it "should respond with an empty success response" do
      post :create
      response.should be_successful
    end

    it "should create a valid optimization session cookie" do
      post :create
      cookies[:opaw_valid_session].should eq(true)
    end

    context "when there are existing test option ids" do
      before do
        @test_option = mock_model Opawesome::TestOption, select!: true
        Opawesome::TestOption.stub(:where){ Opawesome::TestOption }
        Opawesome::TestOption.stub(:first){ @test_option }
        cookies[:opaw_test] = @test_option.id
      end

      it "should find the test option" do
        Opawesome::TestOption.should_receive(:where).with(hash_including(id: @test_option.id))
        post :create
      end

      it "should select the option" do
        @test_option.should_receive(:select!)
        post :create
      end

      context "when the session has already been validated" do
        before do
          cookies[:opaw_valid_session] = true
        end

        it "should not find the test option" do
          Opawesome::TestOption.should_not_receive(:where)
          post :create
        end

        it "should not select the option" do
          @test_option.should_not_receive(:select!)
          post :create
        end
      end
    end
  end
end
