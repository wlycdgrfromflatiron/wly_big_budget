(function TagsIndex(){
    function handleTagsNavbarLinkClick(event){
        event.preventDefault();

        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        // change URL - use pushState
        history.pushState({}, "Tags", `/users/${userId}/tags`)

        // update to show "LOADING"
        const mainDiv = document.getElementById('main-content-column')
        mainDiv.innerHTML = "LOADING TAGS!"

        // send data request
        // when data comes back, parse it and insert it
        fetch(`/users/${userId}/tags.json`)
            .then(response => response.json())
            .then(responseJSON => {
                console.log(responseJSON)
                mainDiv.innerHTML = renderTags(responseJSON)
            })
    }

    // tags have id, name, prefab_stores array, prefab_items array
    // prefab_stores have id, name
    // prefab_items have id, name
    function renderTags(tags){
        html = "<ul>"
        for (let tag of tags){
            html += `<li>${tag.name}</li>`
        }
        html += "</ul>"

        return html
    }

    window.onload = () => {
        const tagsNavbarLink = document.getElementById('tags-navbar-link');

        tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    }
})();

let userIdReady = true
let userId = 1