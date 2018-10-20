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
        event.preventDefault();
        const detailsDiv = document.getElementById('tag-details')
        const selectedTagName = detailsDiv.getElementsByTagName('h3')[0]
        selectedTagName.innerHTML = event.target.innerHTML;
    }

    handleTagsNavbarLinkClick(event){ // user clicks the T in the navbar
        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        event.preventDefault();
        history.pushState({}, "Tags", `/users/${userId}/tags`)
        store.tags ? 
            this.renderStoredTags(this.sortTags(SORT_ALPHA_ASC)) : 
            this.fetchStoreAndRenderTags();
    }

    async fetchStoreAndRenderTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
        this.renderStoredTags(this.sortTags(SORT_ALPHA_ASC))
    }

    renderStoredTags(sortedTags){
        const mainDiv = document.getElementById('main-content-column')
        mainDiv.innerHTML = HandlebarsTemplates["tags/index"]({
            tags: sortedTags,
            selectedTag: sortedTags[0],
        })
        const tagLinks = document.getElementsByClassName('tag-index-link');
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