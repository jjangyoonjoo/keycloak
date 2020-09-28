<#import "template.ftl" as layout>
<@layout.registrationLayout displayWide=(realm.password && social.providers??); section>
  <form id="kc-form-login" class="instsign-form" onsubmit="login.disabled = true; return true;"
        action="${url.loginAction}" method="post">
    <div class="instsign-content instsign-content-login">
      <div class="instsign-content-title">
          ${msg("login-content-title")}
      </div>
      <div class="instsign-login-social-links">
          <#if realm.password && social.providers??>
            <div class="instsign-login-social-link-group">
                <#list social.providers as p>
                    <#if p.alias == "google">
<#--                      <div class="instsign-login-social-link-${p.alias}" onclick="goToUrl('${p.loginUrl}')">-->
                      <div class="instsign-login-social-link-${p.alias}" onclick="displayAlert('${msg("alert-preparing")}')">
                        <div class="instsign-login-social-link-${p.alias}-svg">
                        </div>
                        <div class="instsign-login-social-link-text">
                          <span>${msg("login-social-${p.alias}")}</span>
                        </div>
                      </div>
                    </#if>
                </#list>
                <#list social.providers as p>
                    <#if p.alias == "kakao">
                      <div class="instsign-login-social-link-${p.alias}" onclick="goToUrl('${p.loginUrl}')">
                        <div class="instsign-login-social-link-${p.alias}-svg">
                        </div>
                        <div class="instsign-login-social-link-text">
                          <span>${msg("login-social-${p.alias}")}</span>
                        </div>
                      </div>
                    </#if>
                </#list>
                <#list social.providers as p>
                    <#if p.alias == "naver">
<#--                      <div class="instsign-login-social-link-${p.alias}" onclick="goToUrl('${p.loginUrl}')">-->
                      <div class="instsign-login-social-link-${p.alias}" onclick="displayAlert('${msg("alert-preparing")}')">
                        <div class="instsign-login-social-link-${p.alias}-svg">
                        </div>
                        <div class="instsign-login-social-link-text">
                          <span>${msg("login-social-${p.alias}")}</span>
                        </div>
                      </div>
                    </#if>
                </#list>
<#--                <#list social.providers as p>-->
<#--                    <#if p.alias == "facebook">-->
<#--                      <div class="instsign-login-social-link-${p.alias}" onclick="goToUrl('${p.loginUrl}')">-->
<#--                        <div class="instsign-login-social-link-${p.alias}-svg">-->
<#--                        </div>-->
<#--                        <div class="instsign-login-social-link-text">-->
<#--                          <span>${msg("login-social-${p.alias}")}</span>-->
<#--                        </div>-->
<#--                      </div>-->
<#--                    </#if>-->
<#--                </#list>-->
            </div>
          </#if>
      </div>
      <div class="instsign-content-or">
        <div class="instsign-content-or-divider">
        </div>
        <div class="instsign-content-or-text">
          <span>or</span>
        </div>
        <div class="instsign-content-or-divider">
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-30">
        <div class="instsign-content-input-label">
          <span>${msg("login-content-label-email")}</span>
        </div>
        <div class="instsign-content-input-text">
            <#if usernameEditDisabled??>
              <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" disabled
                     maxlength="100"
              placeholder="${msg("instsign-content-email-placeholder")}" />
            <#else>
              <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" autofocus
                     maxlength="100"
                     autocomplete="off" placeholder="${msg("instsign-content-email-placeholder")}" />
            </#if>
        </div>
      </div>
      <div class="instsign-content-input-group margin-top-20">
        <div class="instsign-content-input-label">
          <span>${msg("login-content-label-password")}</span>
        </div>
        <div class="instsign-content-input-text">
          <input tabindex="2" id="password" name="password" type="password" autocomplete="off"
                 maxlength="12"
                 placeholder="${msg("instsign-content-password-placeholder")}"/>
        </div>
      </div>
      <div class="instsign-button" onclick="clickSubmit('kc-form-login')">
        <span>${msg("login-button")}</span>
      </div>
      <div class="instsign-content-hr">
      </div>
      <div class="instsign-login-forgot-id instsign-link-text"
           onclick="goToUrl('${url.loginFindEmailUrl}')">
        <span>${msg("login-content-forgot-id")}</span>
      </div>
      <div class="instsign-login-register" onclick="goToUrl('${url.registrationUrl}')">
        <span>${msg("login-register-link")}</span>
      </div>
      <br/>
      <div class="instsign-login-forgot-password instsign-link-text"
           onclick="goToUrl('${url.loginResetCredentialsUrl}')">
        <span>${msg("login-content-forgot-password")}</span>
      </div>
    </div>
  </form>
</@layout.registrationLayout>