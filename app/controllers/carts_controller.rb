class CartsController < NestedResourcesController
  before_action {|c| c.session_guard c.this_user_nested? }
  before_action :load_prefabs_and_tags, only: [:additem, :new, :create, :edit]
  before_action :load_user_cart, only: [:additem, :edit, :update, :destroy]

  def additem
    render html: "This is where we will have a form to add another item to cart ##{@cart.id}!"
  end

  def index
    @carts = @user.carts # show note as title and total to start
  end

  def new
    @cart = Cart.new
    @cart.cart_store = CartStore.new
    1.times { @cart.cart_items.build }
  end

  # doubles as #show
  def edit
  end

  def create
    @cart = Cart.new(cart_params)

    @cart.user = @user
    
    if @cart.save
      if params[:cart][:another_item].to_i == 1
        @cart.cart_items.build
        redirect_to "/users/#{@user.id}/carts/#{@cart.id}/additem"
      end
    end
  end

  def update
    super @cart, 'cart', cart_params
  end

  def destroy
    super @cart, user_carts_path
  end

  private

  def cart_params
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

  def load_user_cart
    @cart = @user.carts.find_by(id: params[:id])
    if !@cart
      redirect_to user_carts_path
    end
  end
end
