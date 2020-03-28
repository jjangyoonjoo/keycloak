<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <form id="kc-register-form" action="${url.registrationAction}" method="post">
    <div class="instsign-content instsign-content-register">
      <div class="instsign-content-title">
          ${msg("register-content-title")}
      </div>
      <div class="instsign-content-input-text instsign-content-first-name">
        <input id="firstName" name="firstName" type="text"
               placeholder="${msg("instsign-content-first-name-placeholder")}"/>
      </div>
      <div class="instsign-content-input-text instsign-content-last-name">
        <input id="lastName" name="lastName" type="text"
               placeholder="${msg("instsign-content-last-name-placeholder")}"/>
      </div>
        <#if !realm.registrationEmailAsUsername>
          <div class="instsign-content-input-text instsign-content-username">
            <input id="username" name="username" type="text"
                   autocomplete="username"
                   placeholder="${msg("instsign-content-username-placeholder")}"/>
          </div>
        </#if>
      <div class="instsign-content-input-text instsign-content-email">
        <input id="email" name="email" type="text"
               autocomplete="email"
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
      <div class="instsign-button" onclick="clickSubmit('kc-register-form')">
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