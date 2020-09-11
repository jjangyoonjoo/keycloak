<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <div class="instsign-content instsign-content-error">
    <div class="instsign-content-title">
        ${msg("login-content-title")}
    </div>
    <div class="instsign-content-subtitle instsign-error-text">
        ${message.summary?no_esc}
    </div>
    <div class="instsign-content-footer">
        <#if client?? && client.baseUrl?has_content>
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${client.baseUrl}')">
            <span>${msg("instsign-go-back-to-application-link")}</span>
          </div>
        <#else>
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${url.loginUrl}')">
            <span>${msg("instsign-go-back-to-login-link")}</span>
          </div>
        </#if>
    </div>
  </div>
</@layout.registrationLayout>