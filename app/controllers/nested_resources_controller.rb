# a DRYing abstraction over the various nested resource controllers
class NestedResourcesController < SessionsController
  def create resource_type, resource_params
    resource = resource_type.camelize.constantize.new(resource_params)

    if resource.respond_to? :user
      resource.user = @user
    else
      resource.users << @user
    end

    if resource.save
      edit_path_helper = "edit_user_" + resource_type + "_path"
      redirect_to send(edit_path_helper, @user, resource)
    else
      render :new
    end
  end

  def update resource, resource_name, resource_params
    if resource.update(resource_params)
      edit_resource_path = "edit_user_#{resource_name}_path"
      redirect_to send(edit_resource_path, @user, resource)
    else
      render :edit
    end
  end
end
