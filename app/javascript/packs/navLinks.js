const navLinks = () => {

  const navbarLinks = document.querySelectorAll('.nav_link');

  navbarLinks.forEach((link) => {
   link.addEventListener('click', () => {
     event.preventDefault();
     let section = document.querySelector(link.childNodes[1].getAttribute('href'));
     section.scrollIntoView({
       behavior: 'smooth',
       block: 'start'
     });
   })
  })
}

navLinks();
