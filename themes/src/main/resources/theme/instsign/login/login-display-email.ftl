<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <div class="instsign-content instsign-content-display-email">
    <div class="instsign-content-title">
        ${msg("display-email-content-title")?no_esc}
    </div>
    <div class="instsign-content-subtitle">
         <#if email?? >
        ${email}
         <#else>
             ${msg("id-not-found")}
         </#if>
    </div>
    <div id="resetPassword" class="instsign-button-white"
         onclick="goToUrl('${url.loginResetCredentialsUrl}')">
      <span>${msg("reset-password-button")}</span>
    </div>
      <div id="login" class="instsign-button"
           onclick="goToUrl('${url.loginUrl}')">
          <span>${msg("login-button")}</span>
      </div>
  </div>
</@layout.registrationLayout>