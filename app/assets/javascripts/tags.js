class TagsController {
    constructor(main){
        this.handleTagClick = this.handleTagClick.bind(this)
        this.handleTagsNavbarLinkClick = this.handleTagsNavbarLinkClick.bind(this)

        const tagsNavbarLink = document.getElementById('tags-navbar-link');
        tagsNavbarLink.addEventListener('click', this.handleTagsNavbarLinkClick);

        this.main = main
    }   
    
    // HANDLERS - need to be bound to class instance in constructor
    handlePrefabItemClick(event){
        console.log(event.target.dataset)
        this.main.forwardRenderRequest(RESOURCE_PREFAB_ITEM, event.target.dataset.prefabItemId)
    }

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

        this.renderTagList(store.tags.sorted)
    }
    // /HANDLERS

    async fetchTags(){
        let tags = await fetch(`/users/${userId}/tags.json`)
        store.tags = await tags.json()
    }

    renderSelectedTag(selectedTag){
        this.main.render(
            'tag-details-container',
            HandlebarsTemplates["tags/selectedTag"]({
                tag: selectedTag
            })
        )

        document
            .getElementById('prefab-items-section')
            .addEventListener('click', event => this.handlePrefabItemClick(event))
    }

    renderTagList(tagList){
        this.main.render(
            'tag-list-container',
            HandlebarsTemplates["tags/index"]({
                tags: tagList
            })
        )
        
        document
            .getElementById('tag-list-container')
            .addEventListener('click', event => this.handleTagClick(event))
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