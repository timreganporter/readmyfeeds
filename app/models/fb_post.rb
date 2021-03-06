class FbPost #< Post

  attr_accessor :description, :from

  def initialize(post)
    self.description = post.try(:message)
    self.description = post.try(:description) if self.description.blank?
    if self.description.blank?
      if post.name == "Wall Photos"
        self.description = "Posted a photo. "
        self.description += "Caption: #{ post.caption }" if post.caption
      elsif !post.actions.blank?
        self.description = "Took the following actions: " + post.actions.map{ |a| a.name }.join(", ")
      end
    end
    self.description = self.description.gsub(/http:\S*/, '')
    # big assumption
    if self.description.blank?
      self.description = "Posted a link"
    end
    self.from = post.try(:from).try(:name)
  end

end