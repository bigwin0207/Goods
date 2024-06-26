function login() {
	let login = document.querySelector("#login");

	if (login != null) {

		login.addEventListener("click", function() {
			location.href = "login.do";
		})
	}
}
login();


function gocart() {
	let gocart = document.querySelector("#go_cart");

	if (gocart != null) {

		gocart.addEventListener("click", function() {
			location.href = "viewCartlist.do";
		});
	}
}
gocart();


function gowishlist(){
	let gowish = document.querySelector("#go_wishlist");
	
	if (gowish != null) {
		gowish.addEventListener("click", ()=>{
			location.href = "viewWishlist.do";
		})
	}
}
gowishlist();

document.addEventListener('DOMContentLoaded', () => {
    let containers = document.querySelectorAll('.product-image');

    containers.forEach(container => {
        let images = container.querySelectorAll('img');
        let currentIndex = 0;

        if (images.length > 1) {
            images[currentIndex].classList.add('active');

            setInterval(() => {
                images[currentIndex].classList.remove('active');
                currentIndex = (currentIndex + 1) % images.length;
                images[currentIndex].classList.add('active');
            }, 2000);
        } else if (images.length === 1) {
            images[0].classList.add('active');
        }
    });
});