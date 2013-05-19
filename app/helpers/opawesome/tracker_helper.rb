# TODO: make this less of an ugly mess

module Opawesome::TrackerHelper
  def opaw_select(key, default)
    if cookies["opaw_#{key}"]
      option = Opawesome::TestOption.where(id: cookies["opaw_#{key}"]).first

      if option.nil?
        cookies["opaw_#{key}"] = nil
      else
        return option.value
      end
    end

    test = Opawesome::Test.where(key: key).first_or_initialize

    # set up defaults if the test is new
    if test.new_record?
      test.name = test.key.to_s.humanize
      test.save!
      Opawesome::TestOption.create!(test_id: test.id, value: default, conversion_count: 0, selection_count: 0)
    end

    if cookies[:opaw_ignore]
      test.best_option.value
    else
      # select an option and save it in the user's cookies
      option = test.select_option

      option.select! unless cookies[:opaw_valid_session].nil?

      cookies.permanent["opaw_#{key}"] = option.id
      option.value
    end
  end

  def wtf
    cookies[:opaw_valid_session].nil?
  end

  def opaw_convert!(key)
    return if cookies[:opaw_ignore]

    if cookies["opaw_#{key}"]
      option = Opawesome::TestOption.where(id: cookies["opaw_#{key}"]).first

      if option.nil?
        cookies["opaw_#{key}"] = nil
      else
        option.convert! unless cookies[:opaw_valid_session]
      end
    end
  end

  def check_opaw_ignore
    if params[:opaw_ignore]
      cookies.permanent[:opaw_ignore] = true
    end
  end
end
