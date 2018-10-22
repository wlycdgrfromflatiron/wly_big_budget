class TagsController {
    constructor(){
        this.handleTagClick = this.handleTagClick.bind(this)
        this.handleTagsNavbarLinkClick = this.handleTagsNavbarLinkClick.bind(this)

        const tagsNavbarLink = document.getElementById('tags-navbar-link');
        tagsNavbarLink.addEventListener('click', this.handleTagsNavbarLinkClick);

        if (window.location.pathname.match(/users\/\d\/tags$/)){
            tagsNavbarLink.dispatchEvent(new Event('click'));
        }
    }   
    
    // HANDLERS - need to be bound to class instance in constructor
    handleTagClick(event){ // user clicks a tag in the tag index view
        event.preventDefault();

        const tagId = event.target.dataset.tagId;
        const selectedTag = store.tags.filter(tag => tag.id === parseInt(tagId))[0]

        history.pushState({bananas: "foster"}, `Tag: ${selectedTag.name}`, `/users/${userId}/tags/${selectedTag.id}/edit`)
        //console.log(history);

        this.renderSelectedTag(selectedTag);
    }

    async handleTagsNavbarLinkClick(event){ // user clicks the T in the navbar
        event.preventDefault();

        history.pushState({}, "Tags", `/users/${userId}/tags`)

        store.tags ? 'skip this step' : await this.fetchTags() 

        store.tags.sorted ? 'skip this' : this.sortTags(SORT_ALPHA_ASC)

        this.renderTagsContainers()

        this.renderTagList(store.tags.sorted)
    }
    // /HANDLERS

    async fetchTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
    }

    renderTagsContainers(){        
        const tagDetailsContainer = document.createElement('div');
        tagDetailsContainer.setAttribute('id', 'tag-details-container');

        const tagListContainer = document.createElement('div');
        tagListContainer.setAttribute('id', 'tag-list-container');

        const mainDiv = document.getElementById('main-content-column');
        mainDiv.innerHTML = "";
        mainDiv.appendChild(tagDetailsContainer);
        mainDiv.appendChild(tagListContainer);
    }

    renderSelectedTag(selectedTag){
        document.getElementById('tag-list-container').innerHTML = "";

        const tagDetailsDiv = document.getElementById('tag-details-container');
        
        tagDetailsDiv.innerHTML = 
            HandlebarsTemplates["tags/selectedTag"]({
                tag: selectedTag
            })
    }

    renderTagList(tagList){
        document.getElementById('tag-details-container').innerHTML = "";

        const tagListContainer = document.getElementById('tag-list-container');

        tagListContainer.innerHTML = 
            HandlebarsTemplates["tags/index"]({
                tags: tagList
            })

        tagListContainer.addEventListener('click', event => this.handleTagClick(event))
    }

    sortTags(sort){
        let sortFunc
        switch(sort){
            case SORT_ALPHA_ASC:
                sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
                break;
            default:
                sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
        }
        store.tags.sorted = store.tags.slice().sort(sortFunc)
    }
}