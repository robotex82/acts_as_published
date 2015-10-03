module ActsAsPublished
  module ActiveAdminHelper
    def acts_as_published_actions
      action_item :only => :show do
        if resource.published?
          link_to I18n.t('acts_as_published.actions.unpublish'), self.send(:"toggle_published_#{active_admin_config.namespace.name}_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource)      
        else
          link_to I18n.t('acts_as_published.actions.publish'), self.send(:"toggle_published_#{active_admin_config.namespace.name}_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource)
        end
      end
      
      batch_action :toggle_published do |selection|
        active_admin_config.resource_class.find(selection).each do |item|
          item.toggle_published!
        end
        redirect_to :back
      end 
      
      member_action :toggle_published do
        resource.toggle_published!       
        if resource.published?
          redirect_to :back, :notice => I18n.t('acts_as_published.notices.published', :name => resource )
        else
          redirect_to :back, :notice => I18n.t('acts_as_published.notices.unpublished', :name => resource )
        end 
      end   
    end
    
    def acts_as_published_columns
      column :published do |resource|
        I18n.t(resource.published.to_s)
      end
    end
    
    def acts_as_published_rows
      row :published do |resource|
        I18n.t(resource.published.to_s)
      end
      row :published_at
    end    
  end
end  
