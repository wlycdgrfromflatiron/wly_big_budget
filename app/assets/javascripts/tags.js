class TagIndexController {
    constructor(){
        console.log("TagIndexController constructor entered")

        this.handleTagsNavbarLinkClick = this.handleTagsNavbarLinkClick.bind(this)

        const tagsNavbarLink = document.getElementById('tags-navbar-link');
        tagsNavbarLink.addEventListener('click', this.handleTagsNavbarLinkClick);
        
        if (window.location.pathname.match(/users\/\d\/tags$/)){
            tagsNavbarLink.dispatchEvent(new Event('click'));
        }
    }    
    
    async fetchStoreAndRenderTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
        this.renderStoredTags(this.sortTags(SORT_ALPHA_ASC))
    }

    handleTagsNavbarLinkClick(event){
        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        event.preventDefault();
        history.pushState({}, "Tags", `/users/${userId}/tags`)
        store.tags ? 
            this.renderStoredTags(sortTags(SORT_ALPHA_ASC)) : 
            this.fetchStoreAndRenderTags();
    }

    renderStoredTags(sortedTags){
        const mainDiv = document.getElementById('main-content-column')
        mainDiv.innerHTML = HandlebarsTemplates["tags/index"]({
            tags: sortedTags,
            selectedTag: sortedTags[0]
        })
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

    handleTagClick(event){
        event.preventDefault();
        const detailsDiv = document.getElementById('tag-details')
        const selectedTagName = detailsDiv.getElementsByTagName('h3')[0]
        selectedTagName.innerHTML = event.target.innerHTML;
    }
}