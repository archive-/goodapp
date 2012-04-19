survey "Techincal feedback" do
  section 'Technical' do

    label "Please answer the following questions:"

    q_1 "How often do you use this application?", :pick => :one
    a_1 "Multiple times a day"
    a_2 "Couple of times a week"
    a_3 "Couple of times a month"
    a_4 "Just recently downloaded it"
    a_5 "Rarely"
    a_6 :other

    q_2 "Did the Application download and run successfully? ", :pick => :one, :display_type => :inline
    a_1 "Yes"
    a_2 "No"
    a_3 "I don't know"

    q_2a "Select at least one of the following:", :pick => :any
    a_1  "Crashed while downloading"
    a_2  "Not able to use it at all after download"
    a_3  "Crashes each time it is started"
    a_4  :other
    dependency :rule => "A"
    condition_A :q_2, "==", :a_2

    q_3 "Did the App behave according to its description?", :pick => :one, :display_type => :inline
    a_1 "Yes"
    a_2 "No"
    a_3 "I don't know"  
    
    q_3a "Select all that apply:", :pick => :any
    a_1  "Didn't match the category where it was listed"
    a_2  "Requires real money for the ability to play"
    a_3  "Description doesn’t match the actual Application behavior"
    a_4  :other    
    dependency :rule => "A"
    condition_A :q_3, "==", :a_2  

    q_4 "Did the Application behave as you expected it to? ", :pick => :one, :display_type => :inline
    a_1 "Yes"
    a_2 "No"
    a_3 "I don't know"

    q_4a "Select all that apply:", :pick => :any
    a_1  "Didn’t run at all"
    a_2  "Crashed when clicked on"
    a_3  "Crashes a lot and makes it really hard to use"
    a_4  "Opens a completely different Application"
    a_5  "Caused phone to freeze"
    a_6  "Caused phone to install another Application without consent"
    a_7  "App uses a lot of battery power"
    a_8  "the App charged you money without you consent"
    a_9  "Connected to the Internet"
    a_10 "Got a hold of your personal data with no permission"
    a_11 "Contains a lot of advertizements that get in the way"
    a_12  :other         
    dependency :rule => "A"
    condition_A :q_4, "==", :a_2 
         
    
    label "Rate specific aspects of the Application:"
    label "Scale of (1-10) 1- poor, 10 - great"

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
      q "Consistency", :pick => :one
      q "Power Consumption", :pick => :one
      q "Complexity", :pick => :one
    end

    q "Your overall score for the API of the Application", :display_type => :inline, :pick => :one
    a_1 "Poor"
    a_2 "Average"
    a_3 "Good"
    a_4 "Great"
    a_5 "Awesome"
    a :omit 

    q "Your overall score for this Application", :display_type => :inline, :pick => :one
    a_1 "1 star"
    a_2 "2 stars"
    a_3 "3 starts"
    a_4 "4 stars"
    a_5 "5 stars"
    a :omit  
  end            
end