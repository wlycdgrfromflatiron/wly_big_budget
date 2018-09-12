class CartItemsController < SessionsController
    before_action {|c| c.session_guard c.this_carts_user? }
    before_action :load_cart
    before_action :load_prefab_items_and_tags, only: [:new, :create]

    def new
        @cart_item = CartItem.new
    end

    def create
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