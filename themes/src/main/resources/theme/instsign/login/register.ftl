<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-register-form" action="${url.registrationAction}" method="post">
    <script>
      var LAST_NAMES = ["남궁", "동방", "무본", "서문", "선우", "어금", "제갈", "황목", "황보"];
      function registerSubmit(formId){
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
    </script>
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("register-content-title")}
      </div>
     <#if locale.currentLanguageTag = "ko">
       <div class="instsign-content-input-text instsign-content-first-name">
         <input id="username" name="username" type="text"
                value="${(register.formData.username!'')}"
                placeholder="${msg("instsign-content-first-name-placeholder")}"/>
       </div>
       <input id="firstName" name="firstName" type="hidden" value="${(register.formData.firstName!'')}"/>
       <input id="lastName" name="lastName" type="hidden" value="${(register.formData.lastName!'')}"/>
      <#else>
      <div class="instsign-content-input-text instsign-content-first-name">
        <input id="firstName" name="firstName" type="text"
               value="${(register.formData.firstName!'')}"
               placeholder="${msg("instsign-content-first-name-placeholder")}"/>
      </div>
      <div class="instsign-content-input-text instsign-content-last-name">
        <input id="lastName" name="lastName" type="text"
               value="${(register.formData.lastName!'')}"
               placeholder="${msg("instsign-content-last-name-placeholder")}"/>
      </div>
     </#if>
        <#if !realm.registrationEmailAsUsername>
          <div class="instsign-content-input-text instsign-content-username">
            <input id="username" name="username" type="text"
                   autocomplete="username"
                   value="${(register.formData.username!'')}"
                   placeholder="${msg("instsign-content-username-placeholder")}"/>
          </div>
        </#if>
      <div class="instsign-content-input-text instsign-content-email">
        <input id="email" name="email" type="text"
               autocomplete="email"
               value="${(register.formData.email!'')}"
               placeholder="${msg("instsign-content-email-placeholder")}"/>
      </div>
        <#if passwordRequired>
          <div class="instsign-content-input-text instsign-content-password">
            <input id="password" name="password" type="password" autocomplete="new-password"
                   placeholder="${msg("instsign-content-password-placeholder")}"/>
          </div>
          <div class="instsign-content-input-text instsign-content-confirm-password">
            <input id="password-confirm" name="password-confirm" type="password"
                   placeholder="${msg("instsign-content-confirm-password-placeholder")}"/>
          </div>
        </#if>
      <div class="instsign-button" onclick="registerSubmit('kc-register-form')">
        <span>${msg("register-button")}</span>
      </div>
    </div>
    <div class="instsign-content-footer">
      <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${url.loginUrl}')">
        <span>${msg("instsign-go-back-to-login-link")}</span>
      </div>
    </div>
  </form>
</@layout.registrationLayout>