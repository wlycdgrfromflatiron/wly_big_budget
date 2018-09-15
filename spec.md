# Specifications for the Rails Assessment

Specs:

[See docs/BigBudget_ER_Diagram.png for complete associations diagram]

- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
    -User has_many Carts, PrefabStores, PrefabItems, UserTags
    -Tag has_many UserTags, CartStoreTags, CartItemTags, PrefabItemTags,           PrefabStoreTags
    -PrefabStore has_many CartStores, PrefabStoreTags
    -PrefabItem has_many CartItems, PrefabItemTags
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
    -UserTag belongs_to User, Tag
    -PrefabStore belongs_to User
    -PrefabStoreTag belongs_to PrefabStore, Tag
    -PrefabItem belongs_to User
    -PrefabItemTag belongs_to Prefab_Item, Tag
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
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
- [ ] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
