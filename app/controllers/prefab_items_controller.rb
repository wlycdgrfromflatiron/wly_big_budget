class PrefabItemsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefab_item, only: [:show, :edit, :update, :destroy]
  before_action :load_tags, only: [:index, :new, :create, :edit, :update]

  def index
    @prefab_items = @user.prefab_items

    respond_to do |format|
      format.html { render 'index'}
      format.json { render json: @prefab_items }
    end
  end

  def show
  end

  def new
    @prefab_item = PrefabItem.new
    @resource = @prefab_item
  end

  def edit
  end

  def create
    super 'prefab_item', prefab_item_params
  end

  def update
    super @resource, 'prefab_item', prefab_item_params
  end

  def destroy
    super @prefab_item, user_prefab_items_path
  end

  private

  def prefab_item_params
    params.require(:prefab_item).permit(:name, tag_ids: [])
  end

  def load_prefab_item
    @prefab_item = @user.prefab_items.find_by(id: params[:id])
    if !@prefab_item
      redirect_to user_prefab_items_path
    end
    @resource = @prefab_item
  end

  def load_tags
    @tags = @user.tags
  end
end
