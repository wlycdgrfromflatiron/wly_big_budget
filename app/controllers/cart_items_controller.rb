class CartItemsController < SessionsController
    before_action {|c| c.session_guard c.this_carts_user? }
    before_action :load_cart
    before_action :load_prefab_items_and_tags, only: [:new, :create]

    def new
        @cart_item = CartItem.new
    end

    def create
        # make a new cart_item
        # attach it o cart
        # try to save
        # if it worked,
        #   if user wants to add another item, redirect to :new
        #   if user is done, redirect to carts index
        # if it didn't work, render new
    end

    def destroy
    end

    def load_prefab_items_and_tags
        @prefab_items = @user.prefab_items
        @tags = @user.tags
    end

    def cart_item_params
        require
    end

    def load_cart
        @cart = Cart.find_by(id: params[:cart_id])
        if !@cart
            redirect_to root_path
        end
    end
end