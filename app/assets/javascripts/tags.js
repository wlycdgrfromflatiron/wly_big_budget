(function TagsIndex(){
    function handleTagsNavbarLinkClick(event){
        event.preventDefault();

        console.log("tags navbar link clicked!");
        console.log(`userId: ${userId}`);

        // change URL - use pushState
        history.pushState({}, "Tags", `/users/${userId}/tags`)
        // update to show "LOADING"
        // send data request
        // when data comes back, parse it and insert it

        fetch('/users/1/tags.json')
            .then(response => response.json())
            .then(responseJSON => console.log(responseJSON))

    }

    window.onload = () => {
        const tagsNavbarLink = document.getElementById('tags_navbar_link');

        tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    }
})();

let userIdReady = true
let userId = 1