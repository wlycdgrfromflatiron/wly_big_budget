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
        console.log(data);
        const dataJson = await data.json();
        console.log(dataJson);
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