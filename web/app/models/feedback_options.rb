module FeedbackOptions 
  def get_options
    options = Hash.new
    options["good"] = Hash.new
    options["bad"] = Hash.new

    options["bad"]["bad_1"] = "App crashed at download."
    options["bad"]["bad_2"] = "App crashed at first run."
    options["bad"]["bad_3"] = "App opens another app."
    options["bad"]["bad_4"] = "App charged credit card without user notice."
    options["bad"]["bad_5"] = "App uses network when not supposed. "

    options["good"]["good_1"] = "App behaves as expected. [follows the description]"
    options["good"]["good_2"] = "API is well designed."
    options["good"]["good_3"] = "Easy to use."
    options["good"]["good_4"] = "Updates are consistent and improve performance."
    options["good"]["good_5"] = "Thumbs up for dev."

    return options
  end
end