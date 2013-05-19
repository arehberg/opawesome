class Opawesome::SessionsController < ApplicationController
  def create
    # check for existing option cookies
    unless cookies[:opaw_valid_session]
      cookies.each do |k, v|
        if k[0..4] == 'opaw_' && k != 'opaw_valid_session' && k != 'opaw_ignore'
          option = Opawesome::TestOption.where(id: v).first
          option.select! unless option.nil?
        end
      end
    end

    cookies[:opaw_valid_session] = true
    render nothing: true, status: 200
  end
end
