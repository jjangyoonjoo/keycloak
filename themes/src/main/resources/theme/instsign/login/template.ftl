<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayWide=false>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="robots" content="noindex, nofollow">

      <#if properties.meta?has_content>
          <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
          </#list>
      </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico"/>
      <#if properties.styles?has_content>
          <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
          </#list>
      </#if>
      <#if properties.scripts?has_content>
          <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
          </#list>
      </#if>
      <#if scripts??>
          <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
          </#list>
      </#if>
  </head>

  <body>
  <script>
    function clickSubmit(formId) {
      document.getElementById(formId).submit();
      return false;
    }

    function goToUrl(url) {
      console.log(url);
      window.location.href = url;
      return false;
    }
  </script>
  <div class="instsign-main">
    <div class="instsign-left-menu">
      <div class="instsign-left-menu-logo"></div>
      <div class="instsign-left-menu-title">${msg("login-left-menu.title")}</div>
      <div class="instsign-left-menu-subtitle">${msg("login-left-menu.subtitle")}</div>
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
          <div id="kc-locale">
            <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
              <div class="kc-dropdown" id="kc-locale-dropdown">
<#--                <a href="#" id="kc-current-locale-link">${locale.current}</a>-->
                <ul>
                    <#list locale.supported as l>
                      <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                    </#list>
                </ul>
              </div>
            </div>
          </div>
        </#if>
    </div>
    <div class="instsign-content-wrapper">
      <div id="kc-content-wrapper">
           <#nested "form">
      </div>
    </div>

  </div>
  </body>
  </html>
</#macro>
