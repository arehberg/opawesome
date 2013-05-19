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

  def opaw_add_fields_link(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn", data: {id: id, fields: fields.gsub("\n", "")})
  end
  helper_method :opaw_add_fields_link
end
