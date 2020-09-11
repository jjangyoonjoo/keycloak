<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <script>
        function isEmailValid(email) {
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }
        function emailOnChange(value){
            if (buttonEnabled(value)){
                document.getElementById('submitDiv').className = "instsign-button";
            } else {
                document.getElementById('submitDiv').className ="instsign-button-disabled";
            }
        }
        function buttonEnabled(inputEmail){
            if (inputEmail !== undefined && inputEmail != null && inputEmail.length > 0 && isEmailValid(inputEmail)){
                return true;
            } else {
                return false;
            }
        }
        function validateAndSubmit(formId){
            var email = document.getElementById('username').value;
            if (buttonEnabled(email)){
                clickSubmit(formId);
            }
        }
    </script>
    <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
        <div class="instsign-content instsign-content-reset-password">
            <div class="instsign-content-title">
                ${msg("reset-password-content-title")}
            </div>
            <div class="instsign-content-input-text instsign-content-username">
                <input id="username" name="username" type="email"
                       autofocus onchange="emailOnChange(event.target.value)"
                       placeholder="${msg("instsign-content-email-placeholder")}"/>
            </div>
            <div id="submitDiv" class="instsign-button-disabled" onclick="validateAndSubmit('kc-reset-password-form')">
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