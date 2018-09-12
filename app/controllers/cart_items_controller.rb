class CartItemsController < SessionsController
    before_action {|c| c.session_guard c.this_carts_user? }
    before_action :load_cart
    before_action :load_prefab_items_and_tags, only: [:new, :create]

    def new
        @cart_item = CartItem.new
    end

    def create
        @cart_item = CartItem.new(cart_item_params)

        @cart_item.cart = @cart 

        if @cart_item.save
            if params[:commit] == "Add Another Item"
                redirect_to new_cart_cart_item_path(@cart)
            else
                redirect_to user_carts_path(@user)
            end
        else
            render :new
        end
    end

    def destroy
    end

    private

    def cart_item_params
        params.require(:cart_item).permit(:dollars, :prefab_item_id, :note, tag_ids: [])
    end

    def load_prefab_items_and_tags
        @prefab_items = @user.prefab_items
        @tags = @user.tags
    end

    def load_cart
        @cart = Cart.find_by(id: params[:cart_id])
        if !@cart
            redirect_to root_path
        end
    end
end