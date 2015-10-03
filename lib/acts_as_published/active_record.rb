module ActsAsPublished
  module ActiveRecord
    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
      def acts_as_published
        attr_accessible :published # , :published_at

        def published
          t = self.arel_table
          where(t[:published_at].not_eq(nil))
        end

        def unpublished
          t = self.arel_table
          where(t[:published_at].eq(nil))
        end
      end
    end

    module InstanceMethods
      def published
        !!self.published_at
      end
      alias :published? :published

      def published=(published)
        if ::ActiveRecord::ConnectionAdapters::Column
             .value_to_boolean(published)
          self.published_at = Time.zone.now # .to_date
          # write_attribute(:published_at, Time.zone.now) # .to_date
        else
          self.published_at = nil
          # write_attribute(:published_at, nil)
        end
      end

      def toggle_published
        if self.published_at.nil?
          self.published_at = Time.zone.now # .to_date
          # write_attribute(:published_at, Time.zone.now) # .to_date
        else
          self.published_at = nil
          # write_attribute(:published_at, nil)
        end
      end

      def toggle_published!
        toggle_published
        save!
      end
    end
  end
end

