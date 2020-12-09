const updateNav = () => {
  const navbar = document.querySelector('#bs-navbar');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-blue');
      } else {
        navbar.classList.remove('navbar-blue');
      }
    });
  }
}

updateNav();
