<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
  <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
      <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
      <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>
      <div class="instsign-content instsign-content-update-password">
          <div class="instsign-content-title">
              ${msg("update-password-content-title")}
          </div>
          <div class="instsign-content-input-text instsign-content-password">
              <input id="password-new" name="password-new" type="password" autofocus autocomplete="new-password"
                     placeholder="${msg("instsign-content-password-placeholder")}"/>
          </div>
          <div class="instsign-content-input-text instsign-content-confirm-password">
              <input id="password-confirm" name="password-confirm" type="password" autocomplete="new-password"
                     placeholder="${msg("instsign-content-confirm-password-placeholder")}"/>
          </div>
          <div class="instsign-button" onclick="clickSubmit('kc-passwd-update-form')">
              <span>${msg("update-password-button")}</span>
          </div>
      </div>
      <div class="instsign-content-footer">
          <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${url.loginUrl}')">
              <span>${msg("instsign-go-back-to-login-link")}</span>
          </div>
      </div>
  </form>
</@layout.registrationLayout>
