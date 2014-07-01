require 'spec_helper'

describe Post do
  context 'validations' do
    it { should ensure_inclusion_of(:published).in_array([ true, false ]) }
    context 'with a unpublished_at set' do
      before :each do
        subject.unpublished_at = 1.day.from_now
      end
      
      it { should validate_presence_of :published_at }
    end

    context 'with a unpublished_at == nil' do
      before :each do
        subject.unpublished_at = nil
      end
      
      it { should_not validate_presence_of :published_at }
    end
    
    context 'unpublished_at' do
      subject do
        @post = FactoryGirl.build(:post,
                                  :published_at => 1.day.ago, :unpublished_at => 2.days.ago)
      end # subject

      it 'validates unpublished_at on or after published_at' do
        subject.valid?
        
        expect(subject.errors[:unpublished_at]).to include("must be a date on or after #{@post.published_at}")
      end # it
    end # context 'unpublished_at'
  end # context 'validations'
  
  context 'self#visible' do
    subject { Post.visible.all }

    context 'having an item with attributes published and published_at before now and unpublished before_now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 2.days.ago, :unpublished_at => 1.day.ago)
      end # before :each
      
      it { expect(subject).not_to include(@post) }
    end # context
    
    context 'having an item with attributes published and published_at before now and unpublished after_now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
      
      it { expect(subject).to include(@post) }
    end # context

    context 'having an item with attributes published and published_at before now and unpublished nil' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.day.ago, :unpublished_at => nil)
      end # before :each
    
      it { expect(subject).to include(@post) }
    end # context

    context 'having an item with attributes published and published_at after now and unpublished nil' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.day.from_now, :unpublished_at => nil)
      end # before :each
    
      it { expect(subject).not_to include(@post) }
    end # context

    context 'having an item with attributes unpublished and published_at before now and unpublished after now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => false,
                                          :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
    
      it { expect(subject).not_to include(@post) }
    end # context
  end # context 'self#published'
  
  context 'self#invisible' do
    subject { Post.invisible.all }

    context 'having an item with attributes published and published_at before now and unpublished before_now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 2.days.ago, :unpublished_at => 1.day.ago)
      end # before :each
      
      it { expect(subject).to include(@post) }
    end # context
    
    context 'having an item with attributes published and published_at before now and unpublished after_now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
      
      it { expect(subject).not_to include(@post) }
    end # context

    context 'having an item with attributes published and published_at before now and unpublished nil' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.day.ago, :unpublished_at => nil)
      end # before :each
    
      it { expect(subject).not_to include(@post) }
    end # context

    context 'having an item with attributes published and published_at after now and unpublished nil' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.day.from_now, :unpublished_at => nil)
      end # before :each
    
      it { expect(subject).to include(@post) }
    end # context

    context 'having an item with attributes unpublished and published_at before now and unpublished after now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => false,
                                          :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
    
      it { expect(subject).to include(@post) }
    end # context
  end # context 'self#unpublished'
  
  context '#toggle_published!' do
    context 'for an unpublished item' do
      subject { FactoryGirl.create(:post, :published => false) }

      it 'should toggle from false to true' do
        subject.toggle_published!
        
        expect(subject.published?).to eq(true)
      end # it
    end # context

    context 'for an published item' do
      subject { FactoryGirl.create(:post, :published => true) }

      it 'should toggle from true to false' do
        subject.toggle_published!
        
        expect(subject.published?).to eq(false)
      end # it
    end # context
  end # context 'self#unpublished'
  
  
  context '#visible?' do
    context 'having an item with attributes published and published_at before now and unpublished before_now' do
      before :each do
        @post = FactoryGirl.build(:post, :published => true,
                                  :published_at => 2.days.ago, :unpublished_at => 1.day.ago)
      end # before :each
      
      it { expect(@post).not_to be_visible }
    end # context
    
    context 'having an item with attributes published and published_at before now and unpublished after_now' do
      before :each do
        @post = FactoryGirl.build(:post, :published => true,
                                   :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
      
      it { expect(@post).to be_visible }
    end # context

    context 'having an item with attributes published and published_at before now and unpublished nil' do
      before :each do
        @post = FactoryGirl.build(:post, :published => true,
                                   :published_at => 1.day.ago, :unpublished_at => nil)
      end # before :each
    
      it { expect(@post).to be_visible }
    end # context

    context 'having an item with attributes published and published_at after now and unpublished nil' do
      before :each do
        @post = FactoryGirl.create(:post, :published => true,
                                   :published_at => 1.day.from_now, :unpublished_at => nil)
      end # before :each
    
      it { expect(@post).not_to be_visible }
    end # context

    context 'having an item with attributes unpublished and published_at before now and unpublished after now' do
      before :each do
        @post = FactoryGirl.create(:post, :published => false,
                                          :published_at => 1.days.ago, :unpublished_at => 1.day.from_now)
      end # before :each
    
      it { expect(@post).not_to be_visible }
    end # context
  end # context '#visible?'
end # describe Post
