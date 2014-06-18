class Post < ActiveRecord::Base
  include ActsAsPublished::ActiveRecord
  acts_as_published
  
  attr_accessible :body, :published, :published_at, :title, :unpublished_at
end
