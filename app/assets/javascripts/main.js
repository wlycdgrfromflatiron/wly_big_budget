let userId;
const SORT_ALPHA_ASC = 0;
const store = {}

const RESOURCE_PREFAB_ITEM = 0;

class Main {
    constructor(){
        window.addEventListener('load', () => {
            const userIdDiv = document.getElementById('user-id')
            console.log(userIdDiv);
            console.log(userIdDiv.dataset);

            // user is not logged in (yet)
            if ("" === userIdDiv.dataset.id) return;

            userId = userIdDiv.dataset.id;

            this.prefabItemsController = new PrefabItemsController();
            this.tagsController = new TagsController(this);

            this.mainDiv = document.getElementById('main-content-column')

            if (window.location.pathname.match(/users\/\d\/tags$/)){
                this.tagsController.handleTagsNavbarLinkClick(new Event('click'))
            }
        })
    }

    forwardRenderRequest(resourceType, resourceId){
        switch(resourceType){
        case RESOURCE_PREFAB_ITEM:
            this.prefabItemsController.handleEditViewRequest(resourceId)
        }
    }

    render(divId, html){
        const contentDiv = document.createElement('div')
        contentDiv.setAttribute('id', divId)
        contentDiv.innerHTML = html
        this.mainDiv.innerHTML = ""
        this.mainDiv.appendChild(contentDiv)
    }

    clearScreen(){
        if (this.currentlyActiveDiv){
            this.currentlyActiveDiv
        }
    }
}

new Main();