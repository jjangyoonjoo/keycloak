<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <div class="instsign-content-error-main">
    <div class="instsign-content instsign-content-error">
      <div class="instsign-content-title">
          ${msg("login-content-title")}
      </div>
      <div class="instsign-content-message-body">
        <div class="instsign-content-message-text">
            ${message.summary}
        </div>
      </div>
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