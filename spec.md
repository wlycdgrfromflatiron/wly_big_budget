# Specifications for the Rails Assessment

Specs:

[See docs/BigBudget_ER_Diagram.png for complete associations diagram]

- [x] Using Ruby on Rails for the project

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
    -User has_many Carts, PrefabStores, PrefabItems, UserTags
    -Tag has_many UserTags, CartStoreTags, CartItemTags, PrefabItemTags,           PrefabStoreTags
    -PrefabStore has_many CartStores, PrefabStoreTags
    -PrefabItem has_many CartItems, PrefabItemTags
    -Cart has_many CartItems
    -CartStore has_many CartStoreTags
    -CartItem has_many CartItemTags

    also, Cart has_one CartStore, has_one PrefabStore through CartStore

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
    -UserTag belongs_to User, Tag
    -PrefabStore belongs_to User
    -PrefabStoreTag belongs_to PrefabStore, Tag
    -PrefabItem belongs_to User
    -PrefabItemTag belongs_to Prefab_Item, Tag
    -Cart belongs_to User
    -CartStore belongs_to Cart
    -CartStore belongs_to PrefabStore (optional)
    -CartStoreTag belongs_to Cart_store, Tag
    -CartItem belongs_to Cart, belongs_to PrefabItem (optional)
    -CartItemTag belongs_to CartItem, Tag

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
    -User has_many Tags through UserTags
    -Tag has_many...
        Users through UserTags,
        CartStores through CartStoreTags,
        CartItems through CartItemTags,
        PrefabItems through PrefabItemTags,
        PrefabStores through PrefabStoreTags
    -PrefabStore has_many...
        Tags through PrefabStoreTags,
        Carts through CartStores
    -PrefabItem has_many...
        Carts through CartItems,
        Tags through PrefabItemTags
    -Cart has_many PrefabItems through CartItems
    -CartStore has_many Tags through CartStoreTags
    -CartItem has_many Tags through CartItemTags'

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
    -CartItems join PrefabItems and Carts and have user submittable attributes of price (dollars) and a note and zero to many tags
    -CartStores join PrefabStores and Carts and have a user submittable note attribute and zero to many tags

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    Tag: name presence, User-scoped name uniqueness
    PrefabStore: name presence, User-scoped name uniqueness
    Prefabitem: name presence, User-scoped name uniqueness
    Cart: note presence, date presence, cart store presence, cart item presence
    Cart Store: note presence (unless prefab store)
    Cart Item: note presence (unless prefab item), dollars is a number greater than or equal to 0

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    -Tag::ten_most_popular, at users/:user_id/tags

- [x] Include signup (how e.g. Devise)
    -Hand-rolled
- [x] Include login (how e.g. Devise)
    -Hand-rolled
- [x] Include logout (how e.g. Devise)
    -Hand-rolled
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    -OmniAuth Amazon
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    -users/:id/carts, users/:user_id/carts/:id
    -users/:id/prefab_stores, users/:user_id/prefab_stores/:id
    -users/:id/prefab_items, users/:user_id/prefab_items/:id
    -users/:id/tags, users/:user_id/tags/:id
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
    -carts/:cart_id/cart_items/new
    -users/:id/carts/new
    -users/:id/prefab_stores/new
    -users/:id/prefab_items/new
    -users/:id/tags/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    -carts/:cart_id/cart_items/new
    -users/:id/carts/new, users/:user_id/carts/:id/edit
    -users/:id/prefab_stores/new, users/:user_id/prefab_stores/:id/edit
    -users/:id/prefab_items/new, users/:user_id/prefab_items/:id/edit
    -users/:id/tags/new, users/:user_id/tags/:id/edit

Confirm:
- [x] The application is pretty DRY
    -It's a work in progress, but it's DRYer than it could be
- [x] Limited logic in controllers
    -Not absent, but limited
- [x] Views use helper methods if appropriate
    -See helpers/application_helper.rb
- [x] Views use partials if appropriate
    -See _form partials and views/shared
