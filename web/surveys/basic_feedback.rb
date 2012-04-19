survey "Feedback" do
  section 'Basic' do
    # A label is a question that accepts no answers
    label "Please answer the following questions:"

    # "question" and "answer" may be abbreviated as "q" and "a"
    q_1 "Select ALL Good Characterictics:", :pick => :any
    a_1 "Good API"
    a_2 "Fast and Reliable"
    a_3 "Easy to use"
    a_4 "Updates are consistent and improve performence"
    a_5 "Works well online and offline"
    a_6 "Low battery usage"
    a_7 "Ability to personalize app"  
    a_7 "Uses location services well" 
    a_8 "Overall performs as expected"
    a_9 "Interesting and useful Application"         

    q_2 "Select ALL Bad Characterictics:", :pick => :any
    a_1 "Drains battery"
    a_2 "Contains a lot of advertisements"
    a_3 "Uses services of phone without permission"
    a_4 "Crashes often"
    a_5 "Steals private information"
    a_6 "Triggers unexpected sound/vibrate"
    a_7 "Updates often cause problems"
    a_8 "Uses too much internet"
    a_9 "Charges account without concent"
    a_10 "Opens another applications without concent"  
    a_11 "Location services don't work well"    
    a_12 "Overall desont perform as expected"         

  end
end
