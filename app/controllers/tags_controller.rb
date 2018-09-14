class TagsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs, only: [:new, :edit]
  before_action :load_user_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = @user.tags
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    super 'tag', tag_params
  end

  def update
    super @tag, 'tag', tag_params
  end

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
