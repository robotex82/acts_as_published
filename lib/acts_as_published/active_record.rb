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
        attr_accessible :published if Rails.version < '4'

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
        if Rails.version < '4.2'
          boolean_published = ::ActiveRecord::ConnectionAdapters::Column.value_to_boolean(published)
        else
          boolean_published = ::ActiveRecord::Type::Boolean.new.type_cast_from_user(published)
        end
        self.published_at = boolean_published ? Time.zone.now : nil
      end

      def toggle_published
        if self.published_at.nil?
          self.published_at = Time.zone.now
        else
          self.published_at = nil
        end
      end

      def toggle_published!
        toggle_published
        save!
      end

      def publish
        self.published = true
      end

      def unpublish
        self.published = false
      end
    end
  end
end

