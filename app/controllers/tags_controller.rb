class TagsController < SessionsController
  before_action {|c| c.session_guard c.this_user_nested? }

  def index
    @tags = @user.tags
  end

  def new
    @tag = Tag.new
    @prefab_stores = @user.prefab_stores
    @prefab_items = @user.prefab_items
  end

  #edit (doubles as #show) - name, all the user's prefab items and stores that use it
  def edit
    render html: "This is where we edit the tag woot!"
  end

  #create - make and save the new tag! and, add it to the indicated stores and items
  def create
    tag = Tag.new(tag_params)

    if tag.save
      redirect_to edit_user_tag_path(@user.id, tag.id)
    else
      render :new
    end
  end

  #update - do the #edit changes
  def update
  end

  #delete - confirm that user is ok with all prefabs, cart stores, and cart items losing this tag
  def delete
  end

  private

  def tag_params
    params.require(:tag).permit(:name, prefab_store_ids: [], prefab_item_ids: [])
  end
end
