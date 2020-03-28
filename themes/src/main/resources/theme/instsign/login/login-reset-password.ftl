<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
        <div class="instsign-content instsign-content-reset-password">
            <div class="instsign-content-title">
                ${msg("reset-password-content-title")}
            </div>
            <div class="instsign-content-input-text instsign-content-username">
                <input id="username" name="username" type="text"
                       autofocus
                       placeholder="${msg("instsign-content-email-placeholder")}"/>
            </div>
            <div class="instsign-button" onclick="clickSubmit('kc-reset-password-form')">
                <span>${msg("reset-password-button")}</span>
            </div>
        </div>
        <div class="instsign-content-footer">
            <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${url.loginUrl}')">
                <span>${msg("instsign-go-back-to-login-link")}</span>
            </div>
        </div>
    </form>
</@layout.registrationLayout>