(function TagsIndex(){
    function handleTagsNavbarLinkClick(event){
        event.preventDefault();

        console.log("tags navbar link clicked!");

        fetch('/users/1/tags.json').
        then(function(res){
            console.log(res);
        });
    }

    window.onload = () => {
        const tagsNavbarLink = document.getElementById('tags_navbar_link');

        tagsNavbarLink.addEventListener('click', handleTagsNavbarLinkClick);
    }
})();