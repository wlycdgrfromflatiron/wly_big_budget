# a DRYing abstraction over the various nested resource controllers
class NestedResourcesController < SessionsController
  def create resource_type, resource_params
    resource = resource_type.camelize.constantize.new(resource_params)

    resource.users << @user

    if resource.save
      edit_path_helper = "edit_user_" + resource_type + "_path"
      redirect_to send(edit_path_helper, @user, resource)
    else
      render :new
    end
  end
end
