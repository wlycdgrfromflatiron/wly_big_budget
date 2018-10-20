class PrefabItemsController {
    constructor(){
        console.log("PrefabItemsControllers constructor called")

        const prefabItemsNavbarLink = document.getElementById('prefab-items-navbar-link');
        prefabItemsNavbarLink
            .addEventListener('click', handlePrefabItemsNavbarLinkClick);
        if (window.location.pathname.match(/users\/\d\/prefab_items$/)){
            prefabItemsNavbarLink.dispatchEvent(new Event('click'));
        } 
    }

    handlePrefabItemsNavbarLinkClick(event){
        event.preventDefault();

        console.log("prefab items navbar link clicked!");
        console.log(`userId: ${userId}`);

        // change URL - use pushState
        history.pushState({}, "Prefab Items", `/users/${userId}/prefab_items`)

        // update to show "LOADING"
        const mainDiv = document.getElementById('main-content-column')
        mainDiv.innerHTML = "LOADING YOUR PREFAB ITEMS...."

        // send data request
        // when data comes back, parse it and insert it
        fetch(`/users/${userId}/prefab_items.json`)
            .then(response => response.json())
            .then(responseJSON => {
                console.log(responseJSON)
                mainDiv.innerHTML = HandlebarsTemplates["prefab_items/index"]({
                    header: "All the prefab items!",
                    prefab_items: responseJSON
                })
            })
    }
}