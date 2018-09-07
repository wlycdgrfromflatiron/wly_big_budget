class PrefabStoresController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefab_store, only: [:edit, :update, :destroy]

  def index
    @prefab_stores = @user.prefab_stores
  end

  def new
    @prefab_store = PrefabStore.new
    @tags = @user.tags
  end

  # doubles as #show
  def edit
    render html: "This is where we edit the thing!"
  end

  def create
    prefab_store = PrefabStore.new(prefab_store_params)
    prefab_store.user = @user
    if prefab_store.save
      redirect_to edit_user_prefab_store_path(@user, prefab_store)
    else
      render :new
    end
  end

  def update
    if prefab_store.update(
      name: params[:prefab_store][:name],
      tag_ids: params[:prefab_store][:tag_ids],
    )
      redirect_to edit_user_prefab_store_path(@user, prefab_store)
    else
      render :edit
    end
  end

  def destroy
    @prefab_store.destroy
    redirect_to user_prefab_stores_path
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
  end
end
