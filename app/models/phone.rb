class Phone < ActiveRecord::Base
  belongs_to :user
  attr_accessible :number, :user_id
  before_save :format_number

  protected

  def format_number
    self.number = self.number.gsub(/\D/, '')
  end


end
