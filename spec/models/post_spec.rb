require 'spec_helper'

RSpec.describe Post, type: :model do
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_uniqueness_of(:title) }

  it { expect(subject).to respond_to(:published) }

  describe 'defaults' do
    subject { described_class.new }

    it { expect(subject.published).to be_falsey }
  end

  describe 'setters' do
    subject { described_class.new }

    it { subject.toggle_published; expect(subject.published).to be_truthy }
    it { subject.published = true; expect(subject.published).to be_truthy }
    it { subject.published = false; expect(subject.published).to be_falsey }
    it { subject.publish; expect(subject.published).to be_truthy }
  end

  describe 'initialization with published_at' do
    subject { described_class.new(published_at: Time.zone.now) }
    
    it { expect(subject.published).to be_truthy }
    it { subject.unpublish; expect(subject.published).to be_falsey }
  end
end
