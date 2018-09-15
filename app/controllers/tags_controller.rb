class TagsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs, only: [:new, :edit]
  before_action :load_user_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = @user.tags
  end

  def show
    @prefab_stores = @tag.prefab_stores.select {|ps| ps.user == @user }
    @prefab_items = @tag.prefab_items.select { |pi| pi.user == @user }
  end

  def new
    @tag = Tag.new
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
        render :new
      end
    # if not, create it the usual way
    else
      super 'tag', tag_params
    end
  end

  def update
    super @tag, 'tag', tag_params
  end

  # MUST NOT DESTROY IF OTHER USERS STILL HAVE IT!
  # DELETE ALL THIS USER'S STUFF FROM THE TAG INSTEAD
  def destroy
    super @tag, user_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name, prefab_store_ids: [], prefab_item_ids: [])
  end

  def load_prefabs
    @prefab_stores = @user.prefab_stores
    @prefab_items = @user.prefab_items
  end

  def load_user_tag
    @tag = @user.tags.find_by(id: params[:id])
    if !@tag
      redirect_to user_tags_path
    end
  end
end
