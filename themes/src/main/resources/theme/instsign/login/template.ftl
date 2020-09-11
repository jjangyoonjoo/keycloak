<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayWide=false>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="robots" content="noindex, nofollow">

      <#if properties.meta?has_content>
          <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
          </#list>
      </#if>
    <title>${msg("instsign-page-title")}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico"/>
      <#if properties.styles?has_content>
          <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
          </#list>
      </#if>
      <#if properties.scripts?has_content>
          <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
          </#list>
      </#if>
      <#if scripts??>
          <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
          </#list>
      </#if>
  </head>

  <body>
  <script>
    function clickSubmit(formId) {
      document.getElementById(formId).submit();
      return false;
    }

    function goToUrl(url) {
      console.log(url);
      window.location.href = url;
      return false;
    }

    var REGEX_NUMBER = /[0-9]/;
    var REGEX_LOWER_CASE_ALPHABET = /[a-z]/;
    var REGEX_UPPER_CASE_ALPHABET = /[A-Z]/;
    var REGEX_SPECIAL_CHARACTER = /[~!@#$%^&*()_+|<>?:{}]/;

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
      var isValid = false;
      var emailValue = getElementValueById("email");
      var passwordValue = getElementValueById("password");
      var nameValue = getElementValueById("name");
      var mobilePhoneNumberValue = getElementValueById("mobilePhoneNumber");
      var serviceAgreementValue = getElementValueById('serviceAgreement');
      var privacyAgreementValue = getElementValueById('privacyAgreement');
      var isEmailEntered = (emailValue !== undefined && emailValue !== null && emailValue.length > 0);
      var isPasswordEntered = (passwordValue !== undefined && passwordValue !== null  && passwordValue.length > 0);
      var isNameEntered = (nameValue !== undefined && nameValue !== null  && nameValue.length > 0);
      var isMobilePhoneNumberEntered = (mobilePhoneNumberValue !== undefined && mobilePhoneNumberValue !== null  && mobilePhoneNumberValue.length > 0);
      var isServiceAgreementEntered = isValueTrue(serviceAgreementValue);
      var isPrivacyAgreementEntered = isValueTrue(privacyAgreementValue);
      console.log('validateAllFields', isEmailEntered, isPasswordEntered, isNameEntered, isMobilePhoneNumberEntered, isServiceAgreementEntered, isPrivacyAgreementEntered);
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
      if (isEmailEntered === true && isPasswordEntered === true  &&
        isNameEntered === true && isMobilePhoneNumberEntered === true &&
        isServiceAgreementEntered === true && isPrivacyAgreementEntered === true) {
        isValid = true;
      }
      return isValid;
    }

    function doesValidationErrorExist() {
      return !validateAllFields();
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
      if (!inputElement){
        return true;
      }
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

    function getElementValueById(elementId){
      var localElement = document.getElementById(elementId);
      if(localElement){
        return localElement.value;
      } else {
        return null;
      }
    }

    function isAgreementRequired(updateAllAgreement, inputValidateAllFields) {
      var localAllAgreement = getElementValueById('allAgreement');
      var localServiceAgreement = getElementValueById('serviceAgreement');
      var localPrivacyAgreement = getElementValueById('privacyAgreement');
      var localMarketingAgreement = getElementValueById('marketingAgreement');

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
      if (!inputElement){
        return 0;
      }
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
      var passwordConfirmElement = document.getElementById('password-confirm');
      if (passwordConfirmElement) {
        passwordConfirmElement.value = document.getElementById('password').value;
      }
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
  </script>
  <div class="instsign-main">
    <div class="instsign-header">
      <div class="instsign-header-img">

      </div>
    </div>
    <div class="instsign-content-wrapper">
        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
          <div class="alert alert-${message.type}">
              <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
              <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
              <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
              <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
          </div>
        </#if>
        <#nested "form">
    </div>

  </div>
  </body>
  </html>
</#macro>
