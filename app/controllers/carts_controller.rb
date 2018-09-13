class CartsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs_and_tags, only: [:new, :create, :edit]
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
    cart_params = params[:cart]
    store_params = cart_params[:cart_store_attributes]
    items_params = cart_params[:cart_items_attributes]

    #byebug

    @cart.note = cart_params[:note]
    @cart.date = Date.parse("#{cart_params['date(1i)']}-#{cart_params['date(2i)']}-#{cart_params['date(3i)']}")

    @cart.cart_store.note = store_params[:note]
    @cart.cart_store.prefab_store = PrefabStore.find_by(id: store_params[:prefab_store_id])
    @cart.cart_store.tags = store_params[:tag_ids].map { |tag_id| Tag.find_by(id: tag_id) }

    @cart.cart_items.delete_all
    items_params.each do |item_params|
      cart_item = CartItem.new

      item_params = item_params[1]

      cart_item.note = item_params[:note]
      cart_item.dollars = item_params[:dollars]
      cart_item.prefab_item = PrefabItem.find_by(id: item_params[:prefab_item_id])
      cart_item.tags = item_params[:tag_ids].map { |tag_id| Tag.find_by(id: tag_id) } if item_params[:tag_ids]

      @cart.cart_items << cart_item
    end

    if @cart.save
      redirect_to user_cart_path(@user, @cart)
    else
      render :edit
    end
    # update this to redirect to show once show stubs impelemented for all nested resources
    # super @cart, 'cart', cart_params
  end

  def destroy
    super @cart, user_carts_path
  end

  private

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
