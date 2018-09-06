class TagsController < SessionsController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs, only: [:new, :edit]

  def index
    @tags = @user.tags
  end

  def new
    @tag = Tag.new
  end

  # doubles as #show, cos why not
  def edit
    @tag = Tag.find(params[:id])
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

  #update - do the #edit changes
  def update
    tag = Tag.find(params[:id])

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

  #delete - confirm that user is ok with all prefabs, cart stores, and cart items losing this tag
  def delete
  end

  private

  def tag_params
    params.require(:tag).permit(:name, prefab_store_ids: [], prefab_item_ids: [])
  end

  def load_prefabs
    @prefab_stores = @user.prefab_stores
    @prefab_items = @user.prefab_items
  end
end
