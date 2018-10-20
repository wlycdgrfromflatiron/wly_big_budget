let userId;
const SORT_ALPHA_ASC = 0;
const store = {}

class Main {
    constructor(){
        window.addEventListener('load', () => {
            const userIdDiv = document.getElementById('user-id')
            console.log(userIdDiv);
            console.log(userIdDiv.dataset);

            // user is not logged in (yet)
            if ("" === userIdDiv.dataset.id) return;

            userId = userIdDiv.dataset.id;

            new TagIndexController();
        })
    }
}

new Main();