class Post < ActiveRecord::Base
  include ActsAsPublished::ActiveRecord
  acts_as_published

  validates :title, presence: true, uniqueness: true
end
