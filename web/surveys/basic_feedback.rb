survey "Feedback" do
  section 'Basic' do
    # A label is a question that accepts no answers
    label "Please answer the following questions."

    # "question" and "answer" may be abbreviated as "q" and "a"
    q_1 "Select ALL Good Characterictics:", :pick => :any
    a_1 "Good API"
    a_2 "Fast and Reliable"
    a_3 "Easy to use"
    a_4 "Updates are consistent and improve performence"
    a_5 "Works online and offline"

    q_2 "Select ALL Bad Characterictics:", :pick => :any
    a_1 "Drains battery"
    a_2 "Contains a lot of advertisements"
    a_3 "Uses services of phone without permission"
    a_4 "Crashes often"
    a_5 "Steals private info"
    a_6 "Triggers unexpected sound/vibrate"
    a_7 "Updates often cause problems"
    a_8 "Uses too much internet"
    a_9 "Charges account without concent"

  end
end
