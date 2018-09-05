class TagsController < SessionsController
  #index - show all tags: name, link to details, link to delete
  def index
    unless logged_in? && this_user_nested?
      redirect_to root_path and return
    end

    @user = User.find(session[:user_id])
    @tags = @user.tags
  end

  #new - give name, select prefab items and prefab stores to add the tag to
  def new
  end

  #edit (doubles as #show) - name, all the user's prefab items and stores that use it
  def edit
  end

  #create - make and save the new tag! and, add it to the indicated stores and items
  def create
  end

  #update - do the #edit changes
  def update
  end

  #delete - confirm that user is ok with all prefabs, cart stores, and cart items losing this tag
  def delete
  end
end
