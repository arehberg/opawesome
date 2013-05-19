class Opawesome::TestsController < ApplicationController
  def index
    @tests = Opawesome::Test.order('created_at DESC').all
  end

  def show
    @test = Opawesome::Test.find(params[:id])
    @test_options = @test.options.sort_by {|option| option.conversion_rate }
    @test_options.reverse!
  end

  def edit
    @test = Opawesome::Test.find(params[:id])
  end

  def update
    @test = Opawesome::Test.find(params[:id])

    if @test.update_attributes(params[:opawesome_test])
      redirect_to opawesome_test_path(@test)
    else
      render :edit
    end
  end

  def destroy
    @test = Opawesome::Test.find(params[:id])
    @test.destroy
    redirect_to opawesome_tests_path
  end
end
