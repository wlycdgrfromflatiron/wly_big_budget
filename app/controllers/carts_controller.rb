class CartsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs_and_tags, only: [:new, :create, :edit, :update]
  before_action :load_existing_user_cart, only: [:show, :edit, :update, :destroy]

  def index
    @carts = @user.carts
  end

  def show
    @store = @cart.cart_store
    @items = @cart.cart_items
  end

  def new
    @cart = Cart.new
    @cart.cart_store = CartStore.new
    1.times { @cart.cart_items.build }
  end

  def edit
  end

  def create
    @cart = Cart.new(cart_create_params)

    @cart.user = @user
    
    if @cart.save
      if params[:commit] == "Add Another Item"
        redirect_to new_cart_cart_item_path(@cart)
      else
        redirect_to user_carts_path
      end
    else
        render :new
    end
  end

  def update
    @cart.update(cart_update_params)

    if @cart.save
      redirect_to user_cart_path(@user, @cart)
    else
      render :edit
    end
  end

  def destroy
    super @cart, user_carts_path
  end

  private

  def cart_update_params
    params.require(:cart).permit(
      :note, :date,
      cart_store_attributes: [:id, :note, :prefab_store_id, tag_ids:  []],
      cart_items_attributes: [[:id, :dollars, :note, :prefab_item_id, tag_ids: []]]
    )
  end

  def cart_create_params
    params.require(:cart).permit(
      :note, :date,
      cart_store_attributes: [:note, :prefab_store_id, tag_ids: []],
      cart_items_attributes: [[:dollars, :note, :prefab_item_id, tag_ids: []]]
    )
  end

  def load_prefabs_and_tags
    @prefab_stores = @user.prefab_stores
    @prefab_items = @user.prefab_items
    @tags = @user.tags
  end

  def load_existing_user_cart
    @cart = @user.carts.find_by(id: params[:id])
    if !@cart
      redirect_to user_carts_path
    end
  end
end
