xml.instruct!
xml.Response do
  xml.Say( "Here are your most recent Facebook posts.", :voice => "woman")
  xml.Gather( :action => @gather_action, :numDigits => 1 ) do
    xml.Say "At any time, press any key to hear all your posts from the beginning."
    @feed.posts.each_with_index do |post, index|
      voice = index % 2 == 0 ? "man" : "woman"
      xml.Say( "From: #{ post.from }.", :voice => voice)
      xml.Say( "Message: #{ post.description }.", :voice => voice)
      xml.Pause
    end
  end
end