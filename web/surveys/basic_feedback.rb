survey "Feedback" do
  section 'Basic' do
    # A label is a question that accepts no answers
    label "Please answer the following question"

    # A basic question with radio buttons
    q_1 "Did you feel tricked by application?", :pick => :one
    answer "Very much"
    answer "Sort of"
    answer "Not really"
    answer "No"
  end
end
