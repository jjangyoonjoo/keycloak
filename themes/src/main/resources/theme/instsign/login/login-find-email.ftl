<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <script>
        function inputValueChange(value){
            if (buttonEnabled()){
                document.getElementById('submitDiv').classList.remove("instsign-content-disabled");
            } else {
                document.getElementById('submitDiv').classList.add("instsign-content-disabled");
            }
        }
        function buttonEnabled(){
            var nameValue = document.getElementById('name').value;
            var mobilePhoneNumberValue = document.getElementById('mobilePhoneNumber').value;
            if (nameValue !== undefined && nameValue !== null && nameValue.length > 0 &&
                    mobilePhoneNumberValue !== undefined && mobilePhoneNumberValue !== null && mobilePhoneNumberValue.length > 0){
                return true;
            } else {
                return false;
            }
        }
        function validateAndSubmit(formId){
            if (buttonEnabled()){
                clickSubmit(formId);
            }
        }
    </script>
    <form id="kc-find-email-form" action="${url.loginAction}" method="post">
        <div class="instsign-content instsign-content-find-email">
            <div class="instsign-content-title">
                ${msg("find-email-content-title")?no_esc}
            </div>
            <div class="instsign-content-subtitle">
                ${msg("find-email-content-subtitle")?no_esc}
            </div>
            <div class="instsign-content-input-group margin-top-30">
                <div class="instsign-content-input-label">
                    <span>${msg("find-email-content-name")}</span>
                </div>
                <div class="instsign-content-input-text">
                    <input id="name" name="name" type="text"
                           autocomplete="name"
                           autofocus onchange="inputValueChange(event.target.value)"
                           value="${(name!'')}"
                           placeholder="${msg("instsign-content-name-placeholder")}"/>
                </div>
            </div>
            <div class="instsign-content-input-group margin-top-20">
                <div class="instsign-content-input-label">
                    <span>${msg("find-email-content-mobile-phone-number")}</span>
                </div>
                <div class="instsign-content-input-text">
                    <input id="mobilePhoneNumber" name="mobilePhoneNumber" type="text"
                           autocomplete="mobilePhoneNumber"
                           onchange="inputValueChange(event.target.value)"
                           value="${(mobilePhoneNumber!'')}"
                           placeholder="${msg("instsign-content-mobile-phone-number-placeholder")}"/>
                </div>
            </div>
            <div id="submitDiv" class="instsign-button instsign-content-disabled" onclick="validateAndSubmit('kc-find-email-form')">
                <span>${msg("find-email-button")}</span>
            </div>
            <div class="instsign-content-footer">
                <div class="instsign-link-text instsign-content-footer-login" onclick="goToUrl('${url.loginUrl}')">
                    <span>${msg("instsign-go-back-to-login-link")}</span>
                </div>
            </div>
        </div>
    </form>
</@layout.registrationLayout>