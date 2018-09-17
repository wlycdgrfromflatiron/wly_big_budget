class PrefabStoresController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefab_store, only: [:show, :edit, :update, :destroy]
  before_action :load_tags, only: [:index, :new, :create, :edit, :update]

  def index
    @prefab_stores = @user.prefab_stores
  end

  def show
  end

  def new
    @prefab_store = PrefabStore.new
    @resource = @prefab_store
  end

  def edit
  end

  def create
    super 'prefab_store', prefab_store_params
  end

  def update
    super @resource, 'prefab_store', prefab_store_params
  end

  def destroy
    super @prefab_store, user_prefab_stores_path
  end

  private

  def prefab_store_params
    params.require(:prefab_store).permit(:name, tag_ids: [])
  end

  def load_prefab_store
    @prefab_store = @user.prefab_stores.find_by(id: params[:id])
    if !@prefab_store
      redirect_to user_prefab_stores_path
    end
    @resource = @prefab_store
  end

  def load_tags
    @tags = @user.tags
  end
end
