<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
  <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
      <script>
          function onLoadFunction() {
              console.log('onLoadFunction');
              isRequiredFieldValueEntered(document.getElementById("password-new"));
              isRequiredFieldValueEntered(document.getElementById("password-confirm"));
          }

          window.addEventListener('load', onLoadFunction);
      </script>
      <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
      <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>
      <div class="instsign-content instsign-content-update-password">
          <div class="instsign-content-title">
              ${msg("update-password-content-title")}
          </div>
          <div class="instsign-content-input-group margin-top-30">
              <div class="instsign-content-input-label">
                  <span>${msg("update-password-content-new-password")}</span>
                  <span class="update-password-content-new-password-description">${msg("update-password-content-new-password-description")}</span>
              </div>
              <div class="instsign-content-input-text">
                  <input id="password-new" name="password-new" type="password" autofocus autocomplete="new-password"
                         placeholder="${msg("instsign-content-password-placeholder")}"
                         maxlength="20"
                         onchange="validatePassword(this)"/>
                  <div id="instsign-password-strength-group" class="instsign-password-strength instsign-content-hide">
                      <div class="instsign-password-strength-text">
                          <span>${msg("instsign-password-strength-text")} :</span>
                      </div>
                      <div class="instsign-password-strength-value">
                          <span id="instsign-password-strength-value-span"></span>
                      </div>
                  </div>
              </div>
          </div>
          <div class="instsign-content-input-group margin-top-20">
              <div class="instsign-content-input-label">
                  <span>${msg("update-password-content-new-confirm-password")}</span>
              </div>
              <div class="instsign-content-input-text">
                  <input id="password-confirm" name="password-confirm" type="password" autocomplete="new-password"
                         placeholder="${msg("instsign-content-confirm-password-placeholder")}"
                         maxlength="20"
                         onchange="validatePassword(this)"/>
              </div>
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
