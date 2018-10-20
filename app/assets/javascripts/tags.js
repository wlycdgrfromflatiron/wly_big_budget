class TagsController {
    constructor(){
        console.log("TagIndexController constructor entered")

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
        console.log("handleTagClick called")

        event.preventDefault();
        // extract the tag id
        // find the matching tag entry in the store
        // call renderSelectedTagDiv passing in that matching tag entry
        // BONUS: if user has clicked on the already selected tag, take them to details screen
        console.log(event.target.dataset.tagId);

        const tagId = event.target.dataset.tagId;

        console.log(store.tags)
        const selectedTag = store.tags.filter(tag => tag.id === parseInt(tagId))[0]
        console.log(selectedTag)
        
        document.getElementById('tag-details').innerHTML =
            this.renderSelectedTagDiv(selectedTag)
    }

    async handleTagsNavbarLinkClick(event){ // user clicks the T in the navbar
        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        event.preventDefault();
        history.pushState({}, "Tags", `/users/${userId}/tags`)

        store.tags ? false : await this.fetchTags() 
        this.renderTagsIndex(this.sortTags(SORT_ALPHA_ASC))
        this.attachTagClickListeners()
    }

    async fetchTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
    }

    async fetchAndStoreTagsThenRenderTagsIndex(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
        this.renderTagsIndex(this.sortTags(SORT_ALPHA_ASC))
    }

    renderTagsIndex(sortedTags){
        const mainDiv = document.getElementById('main-content-column')
        const selectedTagDiv = document.createElement('div')
        selectedTagDiv.setAttribute('id', 'tag-details')
        selectedTagDiv.innerHTML = this.renderSelectedTagDiv(sortedTags[0])
        mainDiv.appendChild(selectedTagDiv);

        mainDiv.innerHTML += this.renderTagsList(sortedTags)
    }

    renderSelectedTagDiv(selectedTag){
        return HandlebarsTemplates["tags/selectedTag"]({
                tag: selectedTag
            })
    }

    renderTagsList(sortedTags){
        return HandlebarsTemplates["tags/index"]({
            tags: sortedTags
        })
    }

    attachTagClickListeners(){
        const tagLinks = document.getElementsByClassName('tag-index-link')
        for (const tagLink of tagLinks){
            tagLink.addEventListener('click', event => this.handleTagClick(event))
        }
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