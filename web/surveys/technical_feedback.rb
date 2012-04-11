survey "Techincal feedback" do
  section "Basic questions" do

    q_1 "How often do you use this application?", :pick => :one
    a_1 "Multiple times per day"
    a_2 "Couple of times a week"
    a_3 "Couple of times a month"
    a_4 "Rarely"
    a_6 :other

    q_2 "Was the App downloaded and run successfully? ", :pick => :one, :display_type => :inline
    a_1 "yes"
    a_2 "no"
    a_3 "I don't know"

    q_2a "select at least one of the following:", :pick => :any
    a_1 "crashed at download"
    a_2 "not able to use it at all after download"
    a_3 "crashed at first run"
    dependency :rule => "A"
    condition_A :q_2, "==", :a_2

    q_3 "Did the App behave as you expected it to? ", :pick => :one, :display_type => :inline
    a_1 "yes"
    a_2 "no"
    a_3 "I don't know"

    q_3a "select at least one of the following:", :pick => :any
    a_1 "didn’t run at all"
    a_2 "crashes right when clicked on"
    a_3 "crashes a lot and makes it really hard to use"
    a_4 "opened a completely different App"
    a_5 "caused phone to freeze"
    a_6 "cause phone to install an App without consent"
    dependency :rule => "A"
    condition_A :q_3, "==", :a_2    

    q_4 "Did the App behave according to it’s description?", :pick => :one, :display_type => :inline
    a_1 "yes"
    a_2 "no"
    a_3 "I don't know"  
    
    q_4a "select at least one of the following:", :pick => :any
    a_1 "connected to the Internet"
    a_2 "got a hold of your personal data with no permission"
    a_3 "description doesn’t match to actual App behavior"
    a_4 "the App charged you money without you consent"
    a_5 "App uses a lot of battery power"
    dependency :rule => "A"
    condition_A :q_4, "==", :a_2          

    # When an is_exclusive answer is checked, it unchecks all other options and disables them (using Javascript)
    # since we will kwno the app category we can make it very app specifiv
    # the survey it is - if it a game we can ask one set of questions
    # but if it is say a :news: app, then qquestion would be different...i dunno
    q_4 "Choose App category", :display_type => :inline, :pick => :any
    a "1"
    a "2"
    a "3"
    a "4"
    a "5"
    a "6", :is_exclusive => true
    
    label "Rate specific aspects of the App:"
    label      "Scale of (1-10) 1- poor, 10 - great"

    grid "Rate each of these" do
      a "1"
      a "2"
      a "3"
      a "4"
      a "5"
      a "6"
      a "7"
      a "8"
      a "9"
      a "10"
      q "Security", :pick => :one
      q "Connectivity", :pick => :one
      q "Performance", :pick => :one
      q "Maintainability", :pick => :one
      q "Scalability", :pick => :one
      q "Design of API", :pick => :one
      q "Documentation", :pick => :one
      q "Consistent", :pick => :one
      q "Power Consumption", :pick => :one
      q "Complexity", :pick => :one
      q "Responsivness", :pick => :one
      q "User-friendly", :pick => :one

    end
       
    # A basic question with checkboxes
    # "question" and "answer" may be abbreviated as "q" and "a"
    q "Overall score for the app", :pick => :any
    a_1 "1 star"
    a_2 "2 stars"
    a_3 "3 starts"
    a_4 "4 stars"
    a_5 "5 stars"
    a :omit  
  end            
end