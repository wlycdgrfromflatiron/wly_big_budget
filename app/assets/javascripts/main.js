let userId;
const SORT_ALPHA_ASC = 0;
const store = {}

const RESOURCE_PREFAB_ITEM = 0;

class Main {
    constructor(){
        const userIdDiv = document.getElementById('user-id')
        // user is not logged in (yet)
        if ("" === userIdDiv.dataset.id) return;
        userId = userIdDiv.dataset.id;

        this.loadUserData();

        /*
        this.prefabItemsController = new PrefabItemsController(this);
        this.tagsController = new TagsController(this);

        this.mainDiv = document.getElementById('main-content-column');

        if (this.tagsIndexPage()){
            this.tagsController.handleTagsNavbarLinkClick(new Event('click'));
        }
        */
    }

    forwardRenderRequest(resourceType, resourceId){
        switch(resourceType){
        case RESOURCE_PREFAB_ITEM:
            this.prefabItemsController.handleEditViewRequest(resourceId)
        }
    }

    async loadUserData(){
        const data = await fetch(`/users/${userId}/data.json`);
        //console.log(data);
        const dataJson = await data.json();

        this.unpackUserData(dataJson);
    }

    unpackUserData(dataJson){
        console.log(dataJson);

        store.tags = this.unpack(
            dataJson.tags,  
            {
                'x': 'id', 
                'n': 'name'
            }
        );
        store.prefab_stores = this.unpack(
            dataJson.prefab_stores, 
            {
                'x': 'id', 
                'n': 'name'
            }
        );
        store.prefab_store_tags = this.unpack(
            dataJson.prefab_store_tags,  
            {
                'x': 'id', 
                'p': 'prefab_store_id', 
                't': 'tag_id'
            }
        );
        store.prefab_items = this.unpack(
            dataJson.prefab_items,
            {
                'x' : 'id',
                'n' : 'name'
            }
        );
        store.prefab_item_tags = this.unpack(
            dataJson.prefab_item_tags,
            {
                'x' : 'id',
                'p' : 'prefab_item_id',
                't' : 'tag_id'
            }
        );
        store.carts = this.unpack(
            dataJson.carts,
            {
                'x' : 'id',
                'd' : 'date',
                'n' : 'name'
            }
        );
        store.cart_stores = this.unpack(
            dataJson.cart_stores,
            {
                'x' : 'id',
                'c' : 'cart_id',
                'p' : 'prefab_store_id',
                'n' : 'name'
            }
        );
        store.cart_store_tags = this.unpack(
            dataJson.cart_store_tags,
            {
                'x' : 'id',
                'c' : 'cart_id',
                't' : 'tag_id'
            }
        );
        store.cart_items = this.unpack(
            dataJson.cart_items,
            {
                'x' : 'id',
                'c' : 'cart_id',
                'p' : 'prefab_item_id',
                'n' : 'name',
                'd' : 'dollars'
            }
        );
        store.cart_item_tags = this.unpack(
            dataJson.cart_item_tags,
            {
                'x' : 'id',
                'c' : 'cart_id',
                't' : 'tag_id'
            }
        );
        
        console.log(store);
    }

    unpack(data, longNames){
        data.map(datum => {
            for (const [minifiedName, longName] of Object.entries(longNames)){
                datum[longName] = datum[minifiedName];
                delete datum[minifiedName];
            }
            return datum;
        });

        return data;
    }

    render(divId, html){
        const contentDiv = document.createElement('div');
        contentDiv.setAttribute('id', divId);
        contentDiv.innerHTML = html;
        this.mainDiv.innerHTML = "";
        this.mainDiv.appendChild(contentDiv);
    }

    tagsIndexPage(){
        return ((null === window.location.pathname.match(/users\/\d\/tags$/)) ? false : true);
    }
}

window.addEventListener('load', () => new Main());