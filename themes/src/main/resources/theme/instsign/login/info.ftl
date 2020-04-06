<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <div class="instsign-content-info-main">
    <div class="instsign-content instsign-content-info">
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
        <#if pageRedirectUri??>
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${pageRedirectUri}')">
            <span>${msg("instsign-go-back-to-application-link")}</span>
          </div>
        <#elseif actionUri??>
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${actionUri}')">
            <span>${msg("instsign-proceed-with-action")}</span>
          </div>
        <#elseif client.baseUrl??>
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${client.baseUrl}')">
            <span>${msg("instsign-go-back-to-application-link")}</span>
          </div>
        </#if>
    </div>
  </div>
</@layout.registrationLayout>