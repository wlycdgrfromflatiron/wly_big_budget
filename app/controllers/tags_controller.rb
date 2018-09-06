class TagsController < SessionsController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs, only: [:new, :edit]
  before_action :load_user_tag, only: [:edit, :update, :delete]

  def index
    @tags = @user.tags
  end

  def new
    @tag = Tag.new
  end

  # doubles as #show
  def edit
  end

  def create
    tag = Tag.new(tag_params)
    tag.users << @user
    if tag.save
      redirect_to edit_user_tag_path(@user, tag)
    else
      render :new
    end
  end

  def update
    if tag.update(
      name: params[:tag][:name],
      prefab_store_ids: params[:tag][:prefab_store_ids],
      prefab_item_ids: params[:tag][:prefab_item_ids]
    )
      redirect_to edit_user_tag_path(@user, tag)
    else
      render :edit
    end
  end

  # check that this tag belongs to the logged in user!
  def destroy
    tag.destroy
    redirect_to user_tags_path
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
    tag = @user.tags.find_by(id: params[:id])
    if !tag
      redirect_to user_tags_path
    else
      @tag = tag
    end
  end
end
