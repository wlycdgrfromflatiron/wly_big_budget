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
      show_path_helper = "user_" + resource_type + "_path"
      redirect_to send(show_path_helper, @user, resource)
    else
      render :new
    end
  end

  def update resource, resource_name, resource_params
    if resource.update(resource_params)
      show_resource_path = "user_#{resource_name}_path"
      redirect_to send(show_resource_path, @user, resource)
    else
      render :edit
    end
  end

  def destroy resource, resource_index_path
    resource.destroy
    redirect_to resource_index_path
  end
end
