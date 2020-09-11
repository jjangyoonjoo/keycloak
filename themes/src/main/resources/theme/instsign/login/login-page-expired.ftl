<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <div class="instsign-content instsign-content-expired">
    <div class="instsign-content-title">
        ${msg("expired-content-title")}
    </div>
    <div class="instsign-content-footer">
      <div class="instsign-link-text instsign-content-ib-vt" onclick="goToUrl('${url.loginRestartFlowUrl}')">
        <span>${msg("pageExpiredMsg1")}</span>
      </div>
      <div class="instsign-link-text instsign-content-ib-vt margin-left-20" onclick="goToUrl('${url.loginAction}')">
        <span>${msg("pageExpiredMsg2")}</span>
      </div>
    </div>
  </div>
</@layout.registrationLayout>