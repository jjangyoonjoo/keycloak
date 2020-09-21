<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-update-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
    <script>

      function onLoadFunction() {
        console.log('onLoadFunction');
        isAgreementRequired(false);
        validateAllFields();
      }

      window.addEventListener('load', onLoadFunction);
    </script>
    <input id="password" name="password" type="hidden" value="1111QWwwe!">
    <input name="email" type="hidden"  value="${(user.email!'')}">
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("login-update-profile-content-title")}
      </div>
      <div class="instsign-content-subtitle">
          ${msg("login-update-profile-content-subtitle", "${(socialName!'')}")}
      </div>
      <br/>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-email")}</span>
        </div>
        <div class="instsign-content-input-text instsign-content-disabled">
          <input id="email" name="email1" type="text" disabled
                 value="${(user.email!'')}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-name")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="name" name="name" type="text"
                 onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(name!user.name!'')}"
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
                 maxlength="20"
                 onchange="isRequiredFieldValueEntered(this, true)"
                 value="${(mobilePhoneNumber!user.mobilePhoneNumber!'')}"
                 placeholder="${msg("instsign-content-mobile-phone-number-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("register-content-company")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input id="company" name="company" type="text"
                 autocomplete="company"
                 maxlength="100"
                 value="${(company!user.company!'')}"
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
          <div id="div-all-agreement-dropdown" class="all-agreement-dropdown dropdown-default"
               onclick="onAllAgreementDropdownClick(event)">
          </div>
        </div>
        <div id="register-agreement-option-section" class="register-agreement-select-options instsign-content-hide">
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onServiceAgreementClick(undefined, true, true)">
              <div id="service-agreement-checkbox"
                   class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="serviceAgreement" name="serviceAgreement" type="hidden">
            <div class="register-agreement-text-small" onclick="openNewWindows('https://www.instsign.com/policy/service.html', 800, 800)">
              <span>${msg("register-content-service-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onPrivacyAgreementClick(undefined, true, true)">
              <div id="privacy-agreement-checkbox"
                   class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
            </div>
            <input id="privacyAgreement" name="privacyAgreement" type="hidden">
            <div class="register-agreement-text-small" onclick="openNewWindows('https://www.instsign.com/policy/privacy.html', 800, 800)">
              <span>${msg("register-content-privacy-agreement")}</span>
            </div>
          </div>
          <div class="register-agreement-select-section-row">
            <div class="register-agreement-checkbox-small" onclick="onMarketingAgreementClick(undefined, true, true)">
              <div id="marketing-agreement-checkbox"
                   class="small-agreement-checkbox-checked-svg instsign-content-hide"></div>
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
      <div id="register-button" class="instsign-button" onclick="registerSubmit('kc-update-profile-form')">
        <span>${msg("register-button")}</span>
      </div>
      <div class="register-login-text">
        <span>${msg("register-login-msg")}</span>
      </div>
      <div class="register-login" onclick="goToUrl('${url.loginUrl}')">
        <span>${msg("register-login-link")}</span>
      </div>
    </div>
<#--      <#if user.editUsernameAllowed>-->
<#--        <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">-->
<#--          <div class="${properties.kcLabelWrapperClass!}">-->
<#--            <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>-->
<#--          </div>-->
<#--          <div class="${properties.kcInputWrapperClass!}">-->
<#--            <input type="text" id="username" name="username" value="${(user.username!'')}"-->
<#--                   class="${properties.kcInputClass!}"/>-->
<#--          </div>-->
<#--        </div>-->
<#--      </#if>-->
<#--    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">-->
<#--      <div class="${properties.kcLabelWrapperClass!}">-->
<#--        <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>-->
<#--      </div>-->
<#--      <div class="${properties.kcInputWrapperClass!}">-->
<#--        <input type="text" id="email" name="email" value="${(user.email!'')}" class="${properties.kcInputClass!}"/>-->
<#--      </div>-->
<#--    </div>-->

<#--    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">-->
<#--      <div class="${properties.kcLabelWrapperClass!}">-->
<#--        <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>-->
<#--      </div>-->
<#--      <div class="${properties.kcInputWrapperClass!}">-->
<#--        <input type="text" id="firstName" name="firstName" value="${(user.firstName!'')}"-->
<#--               class="${properties.kcInputClass!}"/>-->
<#--      </div>-->
<#--    </div>-->

<#--    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">-->
<#--      <div class="${properties.kcLabelWrapperClass!}">-->
<#--        <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>-->
<#--      </div>-->
<#--      <div class="${properties.kcInputWrapperClass!}">-->
<#--        <input type="text" id="lastName" name="lastName" value="${(user.lastName!'')}"-->
<#--               class="${properties.kcInputClass!}"/>-->
<#--      </div>-->
<#--    </div>-->

<#--    <div class="${properties.kcFormGroupClass!}">-->
<#--      <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">-->
<#--        <div class="${properties.kcFormOptionsWrapperClass!}">-->
<#--        </div>-->
<#--      </div>-->

<#--      <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">-->
<#--          <#if isAppInitiatedAction??>-->
<#--            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"-->
<#--                   type="submit" value="${msg("doSubmit")}"/>-->
<#--            <button-->
<#--            class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}"-->
<#--            type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>-->
<#--          <#else>-->
<#--            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"-->
<#--                   type="submit" value="${msg("doSubmit")}"/>-->
<#--          </#if>-->
<#--      </div>-->
<#--    </div>-->
  </form>
</@layout.registrationLayout>
