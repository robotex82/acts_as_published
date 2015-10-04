require 'spec_helper'

describe Post do
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }

  it { expect(Post.new).to respond_to(:published) }

  it { expect(Post.new.published).to be_falsey }
  it { post = Post.new(published_at: Time.zone.now); expect(post.published).to be_truthy }
  it { post = Post.new; post.toggle_published; expect(post.published).to be_truthy }
  it { post = Post.new; post.published = true; expect(post.published).to be_truthy }
  it { post = Post.new; post.published = false; expect(post.published).to be_falsey }
  it { post = Post.new; post.publish; expect(post.published).to be_truthy }
  it { post = Post.new(published_at: Time.zone.now); post.unpublish; expect(post.published).to be_falsey }
end
