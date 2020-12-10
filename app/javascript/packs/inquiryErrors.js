const inquiryErrors = () => {
  const submitInquiryButton = document.getElementById('submit-inquiry');
  const nameField = document.getElementById('inquiry_name');
  const phoneField = document.getElementById('inquiry_phone_number');
  const emailField = document.getElementById('inquiry_email');
  submitInquiryButton.addEventListener('click', (event) => {
    if (nameField.value === "") {
      event.preventDefault();
      document.querySelector('#name-error').innerText = "Name cannot be blank.";
    }

    if (phoneField.value === "") {
      event.preventDefault();
      document.querySelector('#phone-error').innerText = "Phone Number cannot be blank.";
    }

    if (emailField.value === "") {
      event.preventDefault();
      document.querySelector('#email-error').innerText = "Email cannot be blank.";
    } else if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailField.value) === false) {
      event.preventDefault();
      document.querySelector('#email-error').innerText = "Must use a valid email.";
    }
  })
}

inquiryErrors();
