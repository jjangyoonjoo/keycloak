<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <div class="instsign-content instsign-content-verify-email">
    <div class="instsign-content-verify-email-header-svg">
    </div>
    <div class="instsign-content-title-group">
      <div class="instsign-content-title">
          ${msg("verify-email-content-title")}
      </div>
      <div class="instsign-content-subtitle">
          ${msg("verify-email-content-subtitle")}
      </div>
    </div>
    <div class="instsign-content-email-address">
      <span></span>
    </div>
  </div>
  <div class="instsign-content-footer instsign-content-verify-email-footer">
    <div class="instsign-content-footer-msg">
        ${msg("verify-email-msg")}
    </div>
    <div class="instsign-link-text instsign-content-footer-resend" onclick="goToUrl('${url.loginAction}')">
      <span>${msg("verify-email-link")}</span>
    </div>
  </div>
</@layout.registrationLayout>