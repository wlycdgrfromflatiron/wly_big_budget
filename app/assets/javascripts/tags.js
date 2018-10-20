const ALPHA_ASC = 0;

const store = {}

function handleTagsNavbarLinkClick(event){
    event.preventDefault();

    console.log("tags navbar link clicked!");
    console.log(`userId: ${userId}`);

    // change URL - use pushState
    history.pushState({}, "Tags", `/users/${userId}/tags`)

    // update to show "LOADING"
    //const mainDiv = document.getElementById('main-content-column')
    //mainDiv.innerHTML = "LOADING TAGS...."

    // send data request
    // when data comes back, parse it and insert it
    store.tags ? renderStoredTags(sortTags(ALPHA_ASC)) : fetchStoreAndRenderTags();
}

function renderStoredTags(sortedTags){
    const mainDiv = document.getElementById('main-content-column')
    mainDiv.innerHTML = HandlebarsTemplates["tags/index"]({
        tags: sortedTags,
        selectedTag: sortedTags[0]
    })
}

async function fetchStoreAndRenderTags(){
    let tags = await fetch(`/users/${userId}/tags.json`)
    store.tags = await tags.json()

    renderStoredTags(sortTags(ALPHA_ASC))
}

function sortTags(sort){
    const sortedTags = store.tags.slice()
    let sortFunc
    switch(sort){
        case ALPHA_ASC:
            sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
            break;
        default:
            sortFunc = (tagA, tagB) => tagA.name.localeCompare(tagB.name);
    }

    return sortedTags.sort(sortFunc)
}

function handleTagClick(event){
    event.preventDefault();
    console.log("Tag clicked!");
    console.log(event.target.innerHTML)

    const detailsDiv = document.getElementById('tag-details')
    const selectedTagName = detailsDiv.getElementsByTagName('h3')[0]
    console.log(selectedTagName)
    console.log(selectedTagName.innerHTML)
    selectedTagName.innerHTML = event.target.innerHTML;
}

window.addEventListener('load', () => {
    console.log("TagsIndex window.onLoad handler called")

    const tagsNavbarLink = document.getElementById('tags-navbar-link');
    tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    if (window.location.pathname.match(/users\/\d\/tags$/)){
        tagsNavbarLink.dispatchEvent(new Event('click'));
    }
})