(function TagsIndex(){
    function handleTagsNavbarLinkClick(event){
        event.preventDefault();

        console.log("tags navbar link clicked!");
    }

    window.onload = () => {
        const tagsNavbarLink = document.getElementById('tags_navbar_link');

        tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    }
})();