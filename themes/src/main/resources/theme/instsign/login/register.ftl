<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-register-form" class="instsign-form" action="${url.registrationAction}" method="post">
    <script>
      var REGEX_NUMBER = /[0-9]/;
      var REGEX_LOWER_CASE_ALPHABET = /[a-z]/;
      var REGEX_UPPER_CASE_ALPHABET = /[A-Z]/;
      var REGEX_SPECIAL_CHARACTER = /[~!@#$%^&*()_+|<>?:{}]/;

      function onLoadFunction() {
        console.log('onLoadFunction');
        isAgreementRequired(false);
        validateAllFields();
      }

      function isValueTrue(inputValue){
        if (inputValue !== undefined && inputValue !== null &&
          (inputValue === true || inputValue === "true")){
          return true;
        } else {
          return false;
        }
      }

      function validateAllFields() {
        isRequiredFieldValueEntered(document.getElementById("email"));
        isRequiredFieldValueEntered(document.getElementById("password"));
        isRequiredFieldValueEntered(document.getElementById("name"));
        isRequiredFieldValueEntered(document.getElementById("mobilePhoneNumber"));
        var emailValue = document.getElementById("email").value;
        var passwordValue = document.getElementById("password").value;
        var nameValue = document.getElementById("name").value;
        var mobilePhoneNumberValue = document.getElementById("mobilePhoneNumber").value;
        var serviceAgreementValue = document.getElementById('serviceAgreement').value;
        var privacyAgreementValue = document.getElementById('privacyAgreement').value;
        var isEmailEntered = (emailValue !== undefined && emailValue !== null && emailValue.length > 0);
        var isPasswordEntered = (passwordValue !== undefined && passwordValue !== null  && passwordValue.length > 0);
        var isNameEntered = (nameValue !== undefined && nameValue !== null  && nameValue.length > 0);
        var isMobilePhoneNumberEntered = (mobilePhoneNumberValue !== undefined && mobilePhoneNumberValue !== null  && mobilePhoneNumberValue.length > 0);
        var isServiceAgreementEntered = isValueTrue(serviceAgreementValue);
        var isPrivacyAgreementEntered = isValueTrue(privacyAgreementValue);
        console.log('validateAllFields', isEmailEntered, isPasswordEntered, isNameEntered, isMobilePhoneNumberEntered, isServiceAgreementEntered, isPrivacyAgreementEntered);
        if (isEmailEntered === true && isPasswordEntered === true  &&
          isNameEntered === true && isMobilePhoneNumberEntered === true) {
          hideRequiredFieldErrorMessage();
        } else {
          displayRequiredFieldErrorMessage();
        }
        if (isServiceAgreementEntered === true && isPrivacyAgreementEntered === true) {
          hideAgreementRequiredErrorMessage();
        } else {
          displayAgreementRequiredErrorMessage();
        }
        if (isEmailEntered === true && isPasswordEntered === true  &&
          isNameEntered === true && isMobilePhoneNumberEntered === true &&
          isServiceAgreementEntered === true && isPrivacyAgreementEntered === true) {
          document.getElementById('register-button').classList.remove("instsign-content-disabled");
        } else {
          document.getElementById('register-button').classList.add("instsign-content-disabled");
        }
      }

      function doesValidationErrorExist() {
        var isErrorMessageDisplayed1 = !document.getElementById('register-validation-require-fields').classList.contains("instsign-content-hide");
        var isErrorMessageDisplayed2 = !document.getElementById('register-validation-accept-agreement').classList.contains("instsign-content-hide");
        return isErrorMessageDisplayed1 || isErrorMessageDisplayed2;
      }

      function displayRequiredFieldErrorMessage() {
        console.log('displayRequiredFieldErrorMessage');
        // document.getElementById('register-validation-require-fields').classList.remove("instsign-content-hide");
        document.getElementById('register-validation-require-fields').classList.remove("instsign-content-hide");
        // document.getElementById('register-button').classList.add("instsign-content-disabled");
      }

      function hideRequiredFieldErrorMessage() {
        console.log('hideRequiredFieldErrorMessage');
        document.getElementById('register-validation-require-fields').classList.add("instsign-content-hide");
        // document.getElementById('register-button').classList.remove("instsign-content-disabled");
      }

      function displayAgreementRequiredErrorMessage() {
        console.log('displayAgreementRequiredErrorMessage');
        // document.getElementById('register-validation-accept-agreement').classList.remove("instsign-content-hide");
        document.getElementById('register-validation-accept-agreement').classList.remove("instsign-content-hide");
        // document.getElementById('register-button').classList.add("instsign-content-disabled");
      }

      function hideAgreementRequiredErrorMessage() {
        console.log('hideAgreementRequiredErrorMessage');
        document.getElementById('register-validation-accept-agreement').classList.add("instsign-content-hide");
        // document.getElementById('register-button').classList.remove("instsign-content-disabled");
      }

      function isRequiredFieldValueEntered(inputElement, inputValidateAllFields) {
        var inputValue = inputElement.value;
        console.log('isRequiredFieldValueEntered:', inputValue, inputElement);
        console.log("::" + inputValue + "::");
        if (inputValue && inputValue.length > 0) {
          inputElement.classList.remove("instsign-error");
          if (inputValidateAllFields === true) {
            validateAllFields();
          }
          return true;
        } else {
          inputElement.classList.add("instsign-error");
          if (inputValidateAllFields === true) {
            validateAllFields();
          }
          return false;
        }
      }

      function isAgreementRequired(updateAllAgreement, inputValidateAllFields) {
        var localAllAgreement = document.getElementById('allAgreement').value;
        var localServiceAgreement = document.getElementById('serviceAgreement').value;
        var localPrivacyAgreement = document.getElementById('privacyAgreement').value;
        var localMarketingAgreement = document.getElementById('marketingAgreement').value;

        console.log('isAgreementRequired', updateAllAgreement, inputValidateAllFields, localAllAgreement, localServiceAgreement, localPrivacyAgreement, localMarketingAgreement);
        if (updateAllAgreement === true) {
          if (isValueTrue(localServiceAgreement) &&
            isValueTrue(localPrivacyAgreement) &&
            isValueTrue(localMarketingAgreement)) {
            allAgreementChecked();
          } else {
            allAgreementUnchecked();
          }
        }
        if (isValueTrue(localServiceAgreement) && isValueTrue(localPrivacyAgreement)) {
          document.getElementById('register-agreement-section').classList.remove("instsign-error");
          document.getElementById('register-agreement-option-section').classList.remove("instsign-error");
          // hideAgreementRequiredErrorMessage();
        } else {
          document.getElementById('register-agreement-section').classList.add("instsign-error");
          document.getElementById('register-agreement-option-section').classList.add("instsign-error");
          // displayAgreementRequiredErrorMessage();
        }
        if (inputValidateAllFields === true) {
          validateAllFields();
        }
      }

      function validatePassword(inputElement) {

        var inputPassword = inputElement.value;
        console.log('validatePassword:' + inputPassword);
        var numberExists = false;
        var lowerCaseAlphabetExists = false;
        var upperCaseAlphabetExists = false;
        var specialCharacterExists = false;
        var lengthGreaterThanSeven = false;
        var validCount = 0;
        if (inputPassword) {
          if (REGEX_NUMBER.test(inputPassword) === true) {
            numberExists = true;
            validCount++;
          }
          if (REGEX_LOWER_CASE_ALPHABET.test(inputPassword) === true) {
            lowerCaseAlphabetExists = true;
            validCount++;
          }
          if (REGEX_UPPER_CASE_ALPHABET.test(inputPassword) === true) {
            upperCaseAlphabetExists = true;
            validCount++;
          }
          if (REGEX_SPECIAL_CHARACTER.test(inputPassword) === true) {
            specialCharacterExists = true;
            validCount++;
          }
          if (inputPassword.length >= 8) {
            lengthGreaterThanSeven = true;
            validCount++;
          }
        }
        console.log('validatePassword:' + inputPassword, validCount, numberExists, lowerCaseAlphabetExists, upperCaseAlphabetExists, specialCharacterExists, lengthGreaterThanSeven);

        if (!inputPassword || inputPassword.length < 1) {
          document.getElementById('instsign-password-strength-group').classList.add("instsign-content-hide");
        } else {
          document.getElementById('instsign-password-strength-group').classList.remove("instsign-content-hide");
        }
        var spanElement = document.getElementById('instsign-password-strength-value-span');
        if (validCount === 5) {
          spanElement.classList.remove("instsign-content-weak");
          spanElement.classList.remove("instsign-content-normal");
          spanElement.classList.remove("instsign-content-strong");
          spanElement.classList.add("instsign-content-strong");
          spanElement.innerHTML = "${msg("instsign-password-strength-strong")}";
        } else if (validCount >= 3) {
          spanElement.classList.remove("instsign-content-weak");
          spanElement.classList.remove("instsign-content-normal");
          spanElement.classList.remove("instsign-content-strong");
          spanElement.classList.add("instsign-content-normal");
          spanElement.innerHTML = "${msg("instsign-password-strength-normal")}";
        } else {
          spanElement.classList.remove("instsign-content-weak");
          spanElement.classList.remove("instsign-content-normal");
          spanElement.classList.remove("instsign-content-strong");
          spanElement.classList.add("instsign-content-weak");
          spanElement.innerHTML = "${msg("instsign-password-strength-weak")}";
        }
        isRequiredFieldValueEntered(inputElement, true);
        return validCount;
      }

      function registerSubmit(formId) {
        if (doesValidationErrorExist()) {
          console.log('registerSubmit error exists');
          return false;
        }
        document.getElementById('password-confirm').value = document.getElementById('password').value;
        clickSubmit(formId);
      }

      function allAgreementChecked() {
        console.log('allAgreementChecked');
        document.getElementById('allAgreement').value = true;
        document.getElementById('all-agreement-checkbox').classList.remove("instsign-content-hide");
      }

      function allAgreementUnchecked() {
        console.log('allAgreementUnchecked');
        document.getElementById('allAgreement').value = false;
        document.getElementById('all-agreement-checkbox').classList.add("instsign-content-hide");
      }

      function onAllAgreementClick(inputValue) {
        var checkedValue = document.getElementById('allAgreement').value;
        console.log('onAllAgreementClick', checkedValue, inputValue);
        if (inputValue) {
          checkedValue = !inputValue;
        }
        if (isValueTrue(checkedValue)) {
          allAgreementUnchecked();
          onServiceAgreementClick(false, false, false);
          onPrivacyAgreementClick(false, false, false);
          onMarketingAgreementClick(false, false, false);
        } else {
          allAgreementChecked();
          onServiceAgreementClick(true, false, false);
          onPrivacyAgreementClick(true, false, false);
          onMarketingAgreementClick(true, false, false);
        }
        // console.log(document.getElementById('all-agreement-checkbox'));
        isAgreementRequired(false, true);
      }

      function onAllAgreementDropdownClick() {
        var checkedValue = document.getElementById('all-agreement-dropdown').value;
        console.log('onAllAgreementDropdownClick', checkedValue);
        if (isValueTrue(checkedValue)) {
          document.getElementById('all-agreement-dropdown').value = false;
          document.getElementById('all-agreement-dropdown').classList.remove("dropdown-clicked");
          document.getElementById('all-agreement-dropdown').classList.add("dropdown-default");
          document.getElementById('register-agreement-option-section').classList.add("instsign-content-hide");
          document.getElementById('register-button').classList.remove("margin-top-155");
        } else {
          document.getElementById('all-agreement-dropdown').value = true;
          document.getElementById('all-agreement-dropdown').classList.remove("dropdown-default");
          document.getElementById('all-agreement-dropdown').classList.add("dropdown-clicked");
          document.getElementById('register-agreement-option-section').classList.remove("instsign-content-hide");
          document.getElementById('register-button').classList.add("margin-top-155");
        }
        // console.log(document.getElementById('all-agreement-dropdown'));
      }


      function onServiceAgreementClick(inputValue, updateAllAgreement, inputValidateAllFields) {
        var checkedValue = document.getElementById('serviceAgreement').value;
        console.log('onServiceAgreementClick', checkedValue, inputValue, updateAllAgreement, inputValidateAllFields);
        if (inputValue) {
          checkedValue = !inputValue;
        }
        if (isValueTrue(checkedValue)) {
          document.getElementById('serviceAgreement').value = false;
          document.getElementById('service-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('serviceAgreement').value = true;
          document.getElementById('service-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('service-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement, inputValidateAllFields);
      }

      function onPrivacyAgreementClick(inputValue, updateAllAgreement, inputValidateAllFields) {
        var checkedValue = document.getElementById('privacyAgreement').value;
        console.log('onPrivacyAgreementClick', checkedValue, inputValue, updateAllAgreement, inputValidateAllFields);
        if (inputValue) {
          checkedValue = !inputValue;
        }
        if (isValueTrue(checkedValue)) {
          document.getElementById('privacyAgreement').value = false;
          document.getElementById('privacy-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('privacyAgreement').value = true;
          document.getElementById('privacy-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('privacy-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement, inputValidateAllFields);
      }

      function onMarketingAgreementClick(inputValue, updateAllAgreement, inputValidateAllFields) {
        var checkedValue = document.getElementById('marketingAgreement').value;
        console.log('onMarketingAgreementClick', checkedValue, inputValue, updateAllAgreement, inputValidateAllFields);
        if (inputValue) {
          checkedValue = !inputValue;
        }
        if (isValueTrue(checkedValue)) {
          document.getElementById('marketingAgreement').value = false;
          document.getElementById('marketing-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('marketingAgreement').value = true;
          document.getElementById('marketing-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('marketing-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement, inputValidateAllFields);
      }

      window.addEventListener('load', onLoadFunction);
    </script>
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("register-content-title")}
      </div>
      <div id="register-validation-require-fields" class="register-validation-required instsign-content-hide">
        <span>${msg("instsign-validation-require-all")}</span>
      </div>
      <br/>
        <#--      <input id="user.attributes.mobilePhoneNumber" name="user.attributes.mobilePhoneNumber" type="hidden" />-->
        <#--      <input id="user.attributes.company" name="user.attributes.company" type="hidden" />-->
        <#--      <input id="user.attributes.serviceAgreement" name="user.attributes.serviceAgreement" type="hidden" />-->
        <#--      <input id="user.attributes.privacyAgreement" name="user.attributes.privacyAgreement" type="hidden" />-->
        <#--      <input id="user.attributes.marketingAgreement" name="user.attributes.marketingAgreement" type="hidden" />-->
      <div class="instsign-content-input-group margin-top-30">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-email")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="email" name="email" type="text"
                 autocomplete="email" onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(register.formData.email!'')}"
                 placeholder="${msg("instsign-content-email-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-password")}</span>
          <span class="register-content-label-password-description">${msg("register-content-password-description")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="password" name="password" type="password" autocomplete="new-password"
                 placeholder="${msg("instsign-content-password-placeholder")}" onchange="validatePassword(this)"/>
          <input id="password-confirm" name="password-confirm" type="hidden"/>
          <div id="instsign-password-strength-group" class="instsign-password-strength instsign-content-hide">
            <div class="instsign-password-strength-text">
              <span>${msg("instsign-password-strength-text")} :</span>
            </div>
            <div class="instsign-password-strength-value">
              <span id="instsign-password-strength-value-span"></span>
            </div>
          </div>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-name")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="name" name="name" type="text"
                 onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(register.formData.name!'')}"
                 placeholder="${msg("instsign-content-name-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-mobile-phone-number")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="mobilePhoneNumber" name="mobilePhoneNumber" type="text"
                 autocomplete="off"
                 onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(register.formData.mobilePhoneNumber!'')}"
                 placeholder="${msg("instsign-content-mobile-phone-number-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-company")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="company" name="company" type="text"
                 autocomplete="off"
                 value="${(register.formData.company!'')}"
                 placeholder="${msg("instsign-content-company-placeholder")}"/>
        </div>
      </div>
      <div id="register-agreement-section" class="register-agreement">
        <div class="register-agreement-select">
          <div class="register-agreement-checkbox" onclick="onAllAgreementClick()">
            <div id="all-agreement-checkbox"
                 class="all-agreement-checkbox-checked-svg instsign-content-hide"></div>
          </div>
          <input id="allAgreement" name="allAgreement" type="hidden"/>
          <input id="all-agreement-dropdown" name="allAgreementDropdown" type="hidden"/>
          <div class="register-agreement-text">
            <span>${msg("register-content-all-agreement")}</span>
          </div>
          <div id="all-agreement-dropdown" class="all-agreement-dropdown dropdown-default"
               onclick="onAllAgreementDropdownClick(event)">
          </div>
        </div>
        <div id="register-agreement-option-section" class="register-agreement-select-options instsign-content-hide">
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onServiceAgreementClick(undefined, true, true)">
              <div id="service-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="serviceAgreement" name="serviceAgreement" type="hidden">
            <div class="register-agreement-text-small">
              <span>${msg("register-content-service-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onPrivacyAgreementClick(undefined, true, true)">
              <div id="privacy-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="privacyAgreement" name="privacyAgreement" type="hidden">
            <div class="register-agreement-text-small">
              <span>${msg("register-content-privacy-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onMarketingAgreementClick(undefined, true, true)">
              <div id="marketing-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="marketingAgreement" name="marketingAgreement" type="hidden">
            <div class="register-agreement-text-small">
              <span>${msg("register-content-marketing-agreement")}</span>
            </div>
          </div>
        </div>
        <div id="register-validation-accept-agreement" class="register-validation-agreement instsign-content-hide">
          <span>${msg("instsign-validation-require-accept")}</span>
        </div>
      </div>
      <div id="register-button" class="instsign-button" onclick="registerSubmit('kc-register-form')">
        <span>${msg("register-button")}</span>
      </div>
      <div class="register-login-text">
        <span>${msg("register-login-msg")}</span>
      </div>
      <div class="register-login" onclick="goToUrl('${url.loginUrl}')">
        <span>${msg("register-login-link")}</span>
      </div>
    </div>
  </form>
</@layout.registrationLayout>