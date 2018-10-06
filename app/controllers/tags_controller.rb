class TagsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_user_tag, only: [:show, :edit, :update, :destroy]
  before_action :load_user_prefabs, only: [:new, :edit, :create, :update]
  before_action :load_user_tag_prefabs, only: [:show]
  

  def index
    @tags = @user.tags

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @tags }
    end
  end

  def show
  end

  def new
    @tag = Tag.new
    @resource = @tag
  end

  def edit
  end

  def create
    # does a tag by this name already exist?
    # if so, associate it with this user
    tp = tag_params
    if (@tag = Tag.find_by(name: tp[:name]))
      @tag.users << @user

      if tp[:prefab_store_ids]
        @tag.prefab_stores.concat(tp[:prefab_store_ids].map { |psi| PrefabStore.find(psi) })
      end

      if tp[:prefab_item_ids]
        @tag.prefab_items.concat(tp[:prefab_items_ids].map { |pii| PrefabItem.find(pii) })
      end
      
      if @tag.save
        redirect_to user_tag_path(@user, @tag)
      else
        @resource = @tag
        render :new
      end
    # if not, create it the usual way
    else
      super 'tag', tag_params
    end
  end

  def update
    super @resource, 'tag', tag_params
  end

  def destroy
    @tag.users = @tag.users.select {|u| u != @user }

    # if the tag has no users left, we can and should destroy it
    if @tag.users.empty?
      super @tag, user_tags_path
    # otherwise, we should just wipe all other memory of THIS user
    else
      @tag.prefab_stores = @tag.prefab_stores.select {|ps| ps.user != @user }
      @tag.prefab_items = @tag.prefab_items.select {|pi| pi.user != @user }

      redirect_to user_tags_path(@user)
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, prefab_store_ids: [], prefab_item_ids: [])
  end

  def load_user_prefabs
    @prefab_stores = @user.prefab_stores
    @prefab_items = @user.prefab_items
  end

  def load_user_tag_prefabs
    @prefab_stores = @tag.prefab_stores.select {|ps| ps.user == @user }
    @prefab_items = @tag.prefab_items.select { |pi| pi.user == @user }
  end

  def load_user_tag
    @tag = @user.tags.find_by(id: params[:id])
    if !@tag
      redirect_to user_tags_path
    end
    @resource = @tag
  end
end
