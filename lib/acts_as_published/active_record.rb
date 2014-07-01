module ActsAsPublished
  module ActiveRecord
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end  
      
      base.validates :published_at, :presence => true, :if => :unpublished_present
      base.validates :unpublished_at, :date => { :on_or_after => :published_at }, :if => :published_and_unpublished_present 
    end  
  
    module ClassMethods
      def acts_as_published
        attr_accessible :published, :published_at, :unpublished_at
        
        def not_published_at_all
          t = self.arel_table
          t[:published_at].eq(nil)
        end

        def published_forever
          t = self.arel_table
          t[:unpublished_at].eq(nil)
        end
        
        def published_in_the_past
          t = self.arel_table
          t[:published_at].lt(Time.zone.now)
        end

        def published_in_the_future
          t = self.arel_table
          t[:published_at].gt(Time.zone.now)
        end
        
        def unpublished_in_the_future
          t = self.arel_table
          t[:unpublished_at].gt(Time.zone.now)
        end

        def unpublished_in_the_past
          t = self.arel_table
          t[:unpublished_at].lt(Time.zone.now)
        end
        
        def visible
          t = self.arel_table
          where(t[:published].eq(true)).
          where(
            published_in_the_past.or(
              not_published_at_all
            )
          ).where(
            unpublished_in_the_future.or(
              published_forever
            )
          )
        end
        
        def invisible
          t = self.arel_table
          where(
            t[:published].eq(false).
            or(
              not_published_at_all.or(
                published_in_the_future
              ).or(
                unpublished_in_the_past
              )
            )
          )
        end
      end
    end
    
    module InstanceMethods
      def toggle_published
        self.published = !self.published
      end
      
      def toggle_published!
        toggle_published
        save!
      end 
      
      def visible?
        return false unless published
        return false if published_at.nil?
        return false if unpublished_at.present? && unpublished_at < Time.zone.now
        return false if published_at > Time.zone.now
        true
      end
      
      private
     
      def published_and_unpublished_present
        published_at.present? && unpublished_at.present?
      end
      
      def unpublished_present
        unpublished_at.present?
      end
    end
  end
end  
