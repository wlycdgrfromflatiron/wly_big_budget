let userIdReady = false
let userId = 0
const SORT_ALPHA_ASC = 0;
const store = {}

class Main {
    constructor(){
        window.addEventListener('load', () => {
            const userIdDiv = document.getElementById('user-id')
            console.log(userIdDiv);
            console.log(userIdDiv.dataset);

            userId = userIdDiv.dataset.id;
            userIdReady = true;

            new TagIndexController();
        })
    }
}

new Main();