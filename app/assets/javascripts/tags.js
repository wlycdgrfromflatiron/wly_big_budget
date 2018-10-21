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

        this.renderSelectedTag(selectedTag);
    }

    async handleTagsNavbarLinkClick(event){ // user clicks the T in the navbar
        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        event.preventDefault();
        history.pushState({}, "Tags", `/users/${userId}/tags`)

        store.tags ? false : await this.fetchTags() 
        this.renderTagsContainers()

        const sortedTags = this.sortTags(SORT_ALPHA_ASC)
        this.renderTagsList(sortedTags)
    }
    // /HANDLERS

    async fetchTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
        console.log(store.tags)
    }

    async fetchAndStoreTagsThenRenderTagsIndex(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
        this.renderTagsIndex(this.sortTags(SORT_ALPHA_ASC))
    }

    renderTagsContainers(sortedTags){        
        const tagDetailsContainer = document.createElement('div');
        tagDetailsContainer.setAttribute('id', 'tag-details-container');

        const tagListContainer = document.createElement('div');
        tagListContainer.setAttribute('id', 'tag-list-container');

        const mainDiv = document.getElementById('main-content-column');
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

    renderTagsList(sortedTags){
        document.getElementById('tag-details-container').innerHTML = "";

        const tagListContainer = document.getElementById('tag-list-container');

        tagListContainer.innerHTML = 
            HandlebarsTemplates["tags/index"]({
                tags: sortedTags
            })

        tagListContainer.addEventListener('click', event => this.handleTagClick(event))
    }

    sortTags(sort){
        console.log("the value of this inside sortTags method is: ");
        console.log(this);

        const sortedTags = store.tags.slice()
        let sortFunc
        switch(sort){
            case SORT_ALPHA_ASC:
                sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
                break;
            default:
                sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
        }
        return sortedTags.sort(sortFunc)
    }
}