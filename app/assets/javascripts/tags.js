function handleTagsNavbarLinkClick(event){
    event.preventDefault();

    console.log("tags navbar link clicked!");
    console.log(`userId: ${userId}`);

    // change URL - use pushState
    history.pushState({}, "Tags", `/users/${userId}/tags`)

    // update to show "LOADING"
    const mainDiv = document.getElementById('main-content-column')
    mainDiv.innerHTML = "LOADING TAGS...."

    // send data request
    // when data comes back, parse it and insert it
    fetch(`/users/${userId}/tags.json`)
        .then(response => response.json())
        .then(responseJSON => {
            console.log(responseJSON)
            mainDiv.innerHTML = HandlebarsTemplates["tags/index"]({
                header: "ALL THE TAGS!",
                tags: responseJSON
            })
        })
}

function handleTagClick(event){
    event.preventDefault();
    console.log("Tag clicked!");
}

window.addEventListener('load', () => {
    console.log("TagsIndex window.onLoad handler called")

    const tagsNavbarLink = document.getElementById('tags-navbar-link');
    tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    if (window.location.pathname.match(/users\/\d\/tags$/)){
        tagsNavbarLink.dispatchEvent(new Event('click'));
    }
})