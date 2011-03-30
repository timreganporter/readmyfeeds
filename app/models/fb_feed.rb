class FbFeed < Feed
  attr_accessor :user, :posts

  def initialize(user)
    super()
    results = Hashie::Mash.new HTTParty::get("https://graph.facebook.com/#{ user.facebook_id }/home", :query => { "access_token" => user.facebook_access_token })
    self.posts = results.data.map do |post|
      FbPost.new(post)
    end
  end

  protected

end