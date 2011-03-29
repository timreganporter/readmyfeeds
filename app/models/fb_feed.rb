class FbFeed < Feed
  attr_accessor :user, :posts

  def initialize(user=nil)
    super()
    self.user = user
  end

  def posts
    posts = self.user.home
    RAILS_DEFAULT_LOGGER.debug("posts = #{ posts }")
    self.posts = posts.map do |post|
      FbPost.new(post)
    end
  end

  protected

end