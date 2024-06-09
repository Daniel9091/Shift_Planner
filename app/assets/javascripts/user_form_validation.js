document.addEventListener("DOMContentLoaded", function() {
    const phoneInput = document.getElementById("user_phone");
    const phoneError = document.getElementById("phone-error");
    const emailInput = document.getElementById("user_email");
    const emailError = document.getElementById("email-error");
    const passwordInput = document.getElementById("user_password");
    const passwordConfirmationInput = document.getElementById("user_password_confirmation");
    const submitButton = document.getElementById("submit-button");
    const passwordMismatchError = document.getElementById("password-mismatch-error");

    function validatePhoneNumber() {
      const phoneNumber = phoneInput.value.trim();
      if (phoneNumber.length !== 9 || !/^\d+$/.test(phoneNumber)) {
        phoneError.textContent = "El teléfono debe tener 9 dígitos.";
        phoneInput.classList.add("is-invalid");
        return false;
      } else {
        phoneError.textContent = "";
        phoneInput.classList.remove("is-invalid");
        return true;
      }
    }

    function validateEmail() {
      const email = emailInput.value.trim();
      if (!validateEmailFormat(email)) {
        emailError.textContent = "Ingrese un correo electrónico válido.";
        emailInput.classList.add("is-invalid");
        return false;
      } else {
        emailError.textContent = "";
        emailInput.classList.remove("is-invalid");
        return true;
      }
    }

    function validateEmailFormat(email) {
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return regex.test(email);
    }

    function validatePassword() {
      if (passwordInput.value !== passwordConfirmationInput.value) {
        passwordMismatchError.style.display = "block";
        return false;
      } else {
        passwordMismatchError.style.display = "none";
        return true;
      }
    }

    function enableSubmitButton() {
      submitButton.disabled = !(validatePhoneNumber() && validateEmail() && validatePassword());
    }

    phoneInput.addEventListener("input", function() {
      validatePhoneNumber();
      enableSubmitButton();
    });

    emailInput.addEventListener("input", function() {
      validateEmail();
      enableSubmitButton();
    });

    passwordInput.addEventListener("input", function() {
      validatePassword();
      enableSubmitButton();
    });

    passwordConfirmationInput.addEventListener("input", function() {
      validatePassword();
      enableSubmitButton();
    });

    validatePhoneNumber();
    validateEmail();
    validatePassword();
    enableSubmitButton();
  });