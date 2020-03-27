<#import "template.ftl" as layout>
<@layout.registrationLayout displayWide=(realm.password && social.providers??); section>
    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
        <div class="instsign-content instsign-content-login">
            <div class="instsign-content-title">
                ${msg("login-content-title")}
            </div>
            <div class="instsign-content-input-text instsign-content-id">
                <#if usernameEditDisabled??>
                    <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" disabled
                           placeholder="${msg("login-content-id-placeholder")}"/>
                <#else>
                    <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" autofocus
                           autocomplete="off" placeholder="${msg("login-content-id-placeholder")}"/>
                </#if>
            </div>
            <div class="instsign-content-input-text instsign-content-password">
                <input tabindex="2" id="password" name="password" type="password" autocomplete="off"
                       placeholder="${msg("login-content-password-placeholder")}"/>
            </div>
            <div class="instsign-content-checkbox">
                <#if login.rememberMe??>
                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked>
                <#else>
                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                </#if>
                <div class="instsign-login-remember">${msg("login-content-remember")}</div>
                <div class="instsign-link-text instsign-login-forgot-password" onclick="goToUrl('${url.loginResetCredentialsUrl}')">
                    <span>${msg("login-content-forgot-password")}</span>
                </div>
            </div>
            <div class="instsign-button" onclick="clickSubmit('kc-form-login')">
                <span>${msg("login-button")}</span>
            </div>
            <div class="instsign-login-social-line">
                <div class="instsign-login-social-line-hr-left"></div>
                <div class="instsign-login-social-line-msg">
                    <span>${msg("login-social-msg")}</span>
                </div>
                <div class="instsign-login-social-line-hr-right"></div>
            </div>
            <div class="instsign-login-social-links">
                <#if realm.password && social.providers??>
                    <div class="instsign-login-social-link-group">
                        <#list social.providers as p>
                            <div class="instsign-login-social-link-${p.alias}" onclick="goToUrl('${p.loginUrl}')">
                                <div class="instsign-login-social-link-${p.alias}-svg">
                                </div>
                                <div class="instsign-login-social-link-text">
                                    <span>${msg("login-social-${p.alias}")}</span>
                                </div>
                            </div>
                        </#list>
                    </div>
                </#if>
            </div>
        </div>
        <div class="instsign-content-footer">
            <div class="instsign-content-footer-msg">
                ${msg("login-register-msg")}
            </div>
            <div class="instsign-link-text instsign-content-footer-register" onclick="goToUrl('${url.registrationUrl}')">
                <span>${msg("login-register-link")}</span>
            </div>
        </div>
    </form>
</@layout.registrationLayout>