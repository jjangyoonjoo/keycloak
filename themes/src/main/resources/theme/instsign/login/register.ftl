<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-register-form" class="instsign-form" action="${url.registrationAction}" method="post">
    <script>
      var LAST_NAMES = ["남궁", "동방", "무본", "서문", "선우", "어금", "제갈", "황목", "황보"];
      var REGEX_NUMBER = /[0-9]/;
      var REGEX_LOWER_CASE_ALPHABET = /[a-z]/;
      var REGEX_UPPER_CASE_ALPHABET = /[A-Z]/;
      var REGEX_SPECIAL_CHARACTER = /[~!@#$%^&*()_+|<>?:{}]/;

      function onLoadFunction(){
        console.log('onLoadFunction');
        isRequiredField(document.getElementById("email"));
        isRequiredField(document.getElementById("password"));
        isRequiredField(document.getElementById("username"));
        isRequiredField(document.getElementById("mobilePhoneNumber"));
        isAgreementRequired(false);
      }
      function isRequiredField(inputElement){
        var inputValue = inputElement.value;
        console.log('isRequiredField:',inputValue, inputElement);
        console.log("::"+inputValue+"::");
        if (inputValue && inputValue.length > 0){
          inputElement.classList.remove("instsign-error");
        } else {
          inputElement.classList.add("instsign-error");
        }
      }

      function isAgreementRequired(updateAllAgreement){
        var localAllAgreement = document.getElementById('allAgreement').value;
        var localServiceAgreement = document.getElementById('serviceAgreement').value;
        var localPrivacyAgreement = document.getElementById('privacyAgreement').value;
        var localMarketingAgreement = document.getElementById('marketingAgreement').value;

        console.log('isAgreementRequired', updateAllAgreement, localAllAgreement, localServiceAgreement, localPrivacyAgreement, localMarketingAgreement);
        if (updateAllAgreement == "true") {
          if (localServiceAgreement == "true" &&
            localPrivacyAgreement == "true" &&
            localMarketingAgreement == "true") {
            allAgreementChecked();
          } else {
            allAgreementUnchecked();
          }
        }
        if (localServiceAgreement == "true" && localPrivacyAgreement == "true"){
          document.getElementById('register-agreement-section').classList.remove("instsign-error");
          document.getElementById('register-agreement-option-section').classList.remove("instsign-error");
        } else {
          document.getElementById('register-agreement-section').classList.add("instsign-error");
          document.getElementById('register-agreement-option-section').classList.add("instsign-error");
        }


      }

      function validatePassword(inputElement){
        isRequiredField(inputElement);
        var inputPassword = inputElement.value;
        console.log('validatePassword:'+inputPassword);
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
          if (inputPassword.length >= 8){
            lengthGreaterThanSeven = true;
            validCount++;
          }
        }
        console.log('validatePassword:'+inputPassword,validCount,numberExists,lowerCaseAlphabetExists,upperCaseAlphabetExists,specialCharacterExists,lengthGreaterThanSeven);

        if (!inputPassword || inputPassword.length < 1){
          document.getElementById('instsign-password-strength-group').classList.add("instsign-content-hide");
        } else {
          document.getElementById('instsign-password-strength-group').classList.remove("instsign-content-hide");
        }
        var spanElement = document.getElementById('instsign-password-strength-value-span');
        if (validCount === 5){
          spanElement.classList.remove("instsign-content-weak");
          spanElement.classList.remove("instsign-content-normal");
          spanElement.classList.remove("instsign-content-strong");
          spanElement.classList.add("instsign-content-strong");
          spanElement.innerHTML = "${msg("instsign-password-strength-strong")}";
        } else if (validCount >= 3){
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

        return validCount;
      }

      function registerSubmit(formId) {
        document.getElementById('password-confirm').value = document.getElementById('password').value;
        // document.getElementById('user.attributes.mobilePhoneNumber').value = document.getElementById('mobilePhoneNumber').value;
        // document.getElementById('user.attributes.company').value = document.getElementById('company').value;
        // document.getElementById('user.attributes.serviceAgreement').value = document.getElementById('serviceAgreement').value;
        // document.getElementById('user.attributes.privacyAgreement').value = document.getElementById('privacyAgreement').value;
        // document.getElementById('user.attributes.marketingAgreement').value = document.getElementById('marketingAgreement').value;
        var userNameElement = document.getElementById('username');
        if (userNameElement) {
          var username = document.getElementById('username').value;
          if (username && username.length > 0) {
            var foundMatchingLastName = false;
            for (var i = 0; i < LAST_NAMES.length; i++) {
              var temp = LAST_NAMES[i];
              if (username.startsWith(temp)) {
                document.getElementById('lastName').value = temp;
                document.getElementById('firstName').value = username.substring(temp.length);
                document.getElementById('username').value = '';
                foundMatchingLastName = true;
                break;
              }
            }
            if (!foundMatchingLastName) {
              document.getElementById('lastName').value = username.substring(0, 1);
              document.getElementById('firstName').value = username.substring(1);
              document.getElementById('username').value = '';
            }
          }
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
        if (inputValue){
          checkedValue = !inputValue;
        }
        if (checkedValue == "true") {
          allAgreementUnchecked();
          onServiceAgreementClick(false);
          onPrivacyAgreementClick(false);
          onMarketingAgreementClick(false);
        } else {
          allAgreementChecked();
          onServiceAgreementClick(true);
          onPrivacyAgreementClick(true);
          onMarketingAgreementClick(true);
        }
        // console.log(document.getElementById('all-agreement-checkbox'));
        // isAgreementRequired();
      }

      function onAllAgreementDropdownClick() {
        var checkedValue = document.getElementById('all-agreement-dropdown').value;
        console.log('onAllAgreementDropdownClick', checkedValue);
        if (checkedValue == "true") {
          document.getElementById('all-agreement-dropdown').value = false;
          document.getElementById('all-agreement-dropdown').classList.remove("dropdown-clicked");
          document.getElementById('all-agreement-dropdown').classList.add("dropdown-default");
          document.getElementById('register-agreement-option-section').classList.add("instsign-content-hide");
          document.getElementById('register-button').classList.remove("margin-top-139");
        } else {
          document.getElementById('all-agreement-dropdown').value = true;
          document.getElementById('all-agreement-dropdown').classList.remove("dropdown-default");
          document.getElementById('all-agreement-dropdown').classList.add("dropdown-clicked");
          document.getElementById('register-agreement-option-section').classList.remove("instsign-content-hide");
          document.getElementById('register-button').classList.add("margin-top-139");
        }
        // console.log(document.getElementById('all-agreement-dropdown'));
      }


      function onServiceAgreementClick(inputValue, updateAllAgreement) {
        var checkedValue = document.getElementById('serviceAgreement').value;
        console.log('onServiceAgreementClick', checkedValue, inputValue);
        if (inputValue){
          checkedValue = !inputValue;
        }
        if (checkedValue == "true") {
          document.getElementById('serviceAgreement').value = false;
          document.getElementById('service-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('serviceAgreement').value = true;
          document.getElementById('service-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('service-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement);
      }

      function onPrivacyAgreementClick(inputValue, updateAllAgreement) {
        var checkedValue = document.getElementById('privacyAgreement').value;
        console.log('onPrivacyAgreementClick', checkedValue, inputValue);
        if (inputValue){
          checkedValue = !inputValue;
        }
        if (checkedValue == "true") {
          document.getElementById('privacyAgreement').value = false;
          document.getElementById('privacy-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('privacyAgreement').value = true;
          document.getElementById('privacy-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('privacy-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement);
      }

      function onMarketingAgreementClick(inputValue, updateAllAgreement) {
        var checkedValue = document.getElementById('marketingAgreement').value;
        console.log('onMarketingAgreementClick', checkedValue, inputValue);
        if (inputValue){
          checkedValue = !inputValue;
        }
        if (checkedValue == "true") {
          document.getElementById('marketingAgreement').value = false;
          document.getElementById('marketing-agreement-checkbox').classList.add("instsign-content-hide");
        } else {
          document.getElementById('marketingAgreement').value = true;
          document.getElementById('marketing-agreement-checkbox').classList.remove("instsign-content-hide");
        }
        // console.log(document.getElementById('marketing-agreement-checkbox'));
        isAgreementRequired(updateAllAgreement);
      }
      window.addEventListener('load', onLoadFunction);
    </script>
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("register-content-title")}
      </div>
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
                 autocomplete="email" onchange="isRequiredField(this)"
                 value="${(register.formData.email!'')}"
                 placeholder="${msg("instsign-content-email-placeholder")}"/>
        </div>
      </div>
        <#if passwordRequired>
          <div class="instsign-content-input-group margin-top-20">
            <div class="instsign-content-input-label">
              <span>${msg("register-content-password")}</span>
              <span class="register-content-label-password-description">${msg("register-content-password-description")}</span>
            </div>
            <div class="instsign-content-input-text">
              <input id="password" name="password" type="password" autocomplete="new-password"
                     placeholder="${msg("instsign-content-password-placeholder")}" onchange="validatePassword(this)"/>
              <input id="password-confirm" name="password-confirm" type="hidden" />
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
        <#--          <div class="instsign-content-input-group margin-top-20">-->
        <#--            <div class="instsign-content-input-label">-->
        <#--              <span>${msg("register-content-confirm-password")}</span>-->
        <#--            </div>-->
        <#--            <div class="instsign-content-input-text">-->
        <#--              <input id="password-confirm" name="password-confirm" type="password"-->
        <#--                     placeholder="${msg("instsign-content-confirm-password-placeholder")}"/>-->
        <#--            </div>-->
        <#--          </div>-->
        </#if>
        <#if locale.currentLanguageTag = "ko">
          <div class="instsign-content-input-group margin-top-20">
            <div class="instsign-content-input-label">
              <span>${msg("register-content-name")}</span>
            </div>
            <div class="instsign-content-input-text">
              <input id="username" name="username" type="text"
                     onchange="isRequiredField(this)"
                     value="${(register.formData.username!'')}"
                     placeholder="${msg("instsign-content-name-placeholder")}"/>
            </div>
            <input id="firstName" name="firstName" type="hidden" value="${(register.formData.firstName!'')}"/>
            <input id="lastName" name="lastName" type="hidden" value="${(register.formData.lastName!'')}"/>
          </div>
        <#else>
          <div class="instsign-content-input-group margin-top-20">
            <div class="instsign-content-input-label">
              <span>${msg("register-content-first-name")}</span>
            </div>
            <div class="instsign-content-input-text">
              <input id="firstName" name="firstName" type="text"
                     onchange="isRequiredField(this)"
                     value="${(register.formData.firstName!'')}"
                     placeholder="${msg("instsign-content-first-name-placeholder")}"/>
            </div>
          </div>
          <div class="instsign-content-input-group margin-top-20">
            <div class="instsign-content-input-label">
              <span>${msg("register-content-last-name")}</span>
            </div>
            <div class="instsign-content-input-text">
              <input id="lastName" name="lastName" type="text"
                     onchange="isRequiredField(this)"
                     value="${(register.formData.lastName!'')}"
                     placeholder="${msg("instsign-content-last-name-placeholder")}"/>
            </div>
          </div>
        </#if>
        <#if !realm.registrationEmailAsUsername>
          <div class="instsign-content-input-group margin-top-20">
            <div class="instsign-content-input-label">
              <span>${msg("register-content-username")}</span>
            </div>
            <div class="instsign-content-input-text">
              <input id="username" name="username" type="text"
                     autocomplete="username"
                     onchange="isRequiredField(this)"
                     value="${(register.formData.username!'')}"
                     placeholder="${msg("instsign-content-username-placeholder")}"/>
            </div>
          </div>
        </#if>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-mobile-phone-number")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="mobilePhoneNumber" name="mobilePhoneNumber" type="text"
                 autocomplete="off"
                 onchange="isRequiredField(this)"
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
          <div class="register-agreement-select-section-row" >
            <div class="register-agreement-checkbox-small" onclick="onServiceAgreementClick(undefined, true)">
              <div id="service-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="serviceAgreement" name="serviceAgreement" type="hidden" >
            <div class="register-agreement-text-small">
              <span>${msg("register-content-service-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onPrivacyAgreementClick(undefined, true)">
              <div id="privacy-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="privacyAgreement" name="privacyAgreement" type="hidden" >
            <div class="register-agreement-text-small">
              <span>${msg("register-content-privacy-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onMarketingAgreementClick(undefined, true)">
              <div id="marketing-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="marketingAgreement" name="marketingAgreement" type="hidden" >
            <div class="register-agreement-text-small">
              <span>${msg("register-content-marketing-agreement")}</span>
            </div>
          </div>
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