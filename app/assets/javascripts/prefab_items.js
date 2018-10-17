(function PrefabItems(){
    function handlePrefabItemsNavbarLinkClick(event){
        event.preventDefault();

        console.log("prefab items navbar link clicked!");
        console.log(`userId: ${userId}`);

        // change URL - use pushState
        history.pushState({}, "Prefab Items", `/users/${userId}/prefab_items`)

        // update to show "LOADING"
        const mainDiv = document.getElementById('main-content-column')
        mainDiv.innerHTML = "LOADING TAGS...."

        // send data request
        // when data comes back, parse it and insert it
        fetch(`/users/${userId}/prefab_items.json`)
            .then(response => response.json())
            .then(responseJSON => {
                console.log(responseJSON)
                /*
                mainDiv.innerHTML = HandlebarsTemplates["tags/index"]({
                    header: "ALL THE TAGS!",
                    tags: responseJSON
                })
                */
            })
    }

    window.addEventListener('load', () => {
        document.getElementById('prefab-items-navbar-link')
            .addEventListener('click', handlePrefabItemsNavbarLinkClick);

        console.log("PrefabItems window.onLoad handler called")
    })
})();