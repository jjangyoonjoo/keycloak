<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-register-form" class="instsign-form" action="${url.registrationAction}" method="post">
    <script>

      function onLoadFunction() {
        console.log('onLoadFunction');
        isAgreementRequired(false);
        validateAllFields();
      }

      window.addEventListener('load', onLoadFunction);
    </script>
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("register-content-title")}
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
                 maxlength="100"
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
                 maxlength="12"
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
                 maxlength="50"
                 placeholder="${msg("instsign-content-name-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-mobile-phone-number")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="mobilePhoneNumber" name="mobilePhoneNumber" type="text"
                 autocomplete="mobilePhoneNumber"
                 onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(register.formData.mobilePhoneNumber!'')}"
                 maxlength="20"
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
                 maxlength="100"
                 value="${(register.formData.company!'')}"
                 placeholder="${msg("instsign-content-company-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-referral-code")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="referredByCode" name="referredByCode" type="text"
                 autocomplete="off" maxlength="6"
                 value="${(register.formData.referredByCode!'')}"/>
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
          <div id="div-all-agreement-dropdown" class="all-agreement-dropdown dropdown-default"
               onclick="onAllAgreementDropdownClick(event)">
          </div>
        </div>
        <div id="register-agreement-option-section" class="register-agreement-select-options instsign-content-hide">
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onServiceAgreementClick(undefined, true, true)">
              <div id="service-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="serviceAgreement" name="serviceAgreement" type="hidden">
            <div class="register-agreement-text-small" onclick="openNewWindows('https://www.instsign.com/policy/service.html', 800, 800)">
              <span>${msg("register-content-service-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onPrivacyAgreementClick(undefined, true, true)">
              <div id="privacy-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="privacyAgreement" name="privacyAgreement" type="hidden">
            <div class="register-agreement-text-small" onclick="openNewWindows('https://www.instsign.com/policy/privacy.html', 800, 800)">
              <span>${msg("register-content-privacy-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onMarketingAgreementClick(undefined, true, true)">
              <div id="marketing-agreement-checkbox" class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="marketingAgreement" name="marketingAgreement" type="hidden">
            <div class="register-agreement-text-small" onclick="openNewWindows('https://www.instsign.com/policy/marketing.html', 800, 800)">
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