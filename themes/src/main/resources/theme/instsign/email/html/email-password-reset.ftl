<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>InstSign</title>
  <script type="text/javascript"></script>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"
        type="text/css">
  <link rel="stylesheet" type="text/css"
        href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
  <style type="text/css" th:inline="text">
    @import url("https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css");

    body {
      font-family: 'NanumSquare', 'Noto Sans KR', sans-serif;
      font-weight: 400;
      background-color: #ffffff;
    }

    .email-content {
      display: block;
      margin-left: auto;
      margin-right: auto;
      width: 600px;
      padding-top: 23px;
    }

    .email-top-section{
      display: inline-block;
      vertical-align: top;
      border: solid 1px #efeff4;
      padding-top: 15px;
      width: 600px;
      background-color: #ffffff;
    }

    .email-header {
      display: inline-block;
      vertical-align: top;
      height: 50px;
      width: 100%;
    }

    .email-header-logo {
    }

    a:hover, a:active, a:link, a:visited {
      text-decoration: none;
      border: none;
    }

    .email-header-logo .logo {
      margin-left: 30px;
      margin-top: 12px;
      width: 107px;
      height: 15px;
      object-fit: contain;
    }

    .email-header-link-button {
      position: relative;
      padding: 5px 8px;
      margin-right: 30px;
      float: right;
      text-align: center;
      height: 18px;
      border-radius: 2px;
      border: solid 1px #cacaca;
      background-color: #ffffff;
    }

    .email-header-link-button span {
      width: 150px;
      height: 11px;
      font-weight: 700;
      font-size: 13px;
      font-stretch: normal;
      font-style: normal;
      line-height: 0.85;
      letter-spacing: normal;
      text-align: center;
      color: #000000;
    }

    .email-title {
      display: inline-block;
      vertical-align: top;
      margin: 30px 30px 0 30px;
      width: 530px;
      height: auto;
      font-size: 26px;
      font-weight: 800;
      font-stretch: normal;
      font-style: normal;
      line-height: 1.51;
      letter-spacing: normal;
    }

    .email-title-1 {
      color: #000000;
    }

    .email-title-2 {
      color: #275ae6;
    }

    .email-subtitle {
      display: inline-block;
      vertical-align: top;
      margin: 20px 30px 0 30px;
      width: 530px;
      height: auto;
      font-size: 14px;
      font-weight: 400;
      font-stretch: normal;
      font-style: normal;
      line-height: 1.49;
      letter-spacing: normal;
      color: #000000;
    }

    .email-subtitle-1 {
    }

    .email-subtitle-2 {
    }

    .email-button-container {
      margin: 40px 30px 30px 30px;
      display: inline-block;
      text-align: center;
      height: 40px;
    }

    .email-button-container .email-main-button {
      border-radius: 2px;
      background-color: #275ae6;
      margin: 0;
      padding: 13px 19px;
      width: 100%;
      height: 14px;
      font-size: 14px;
      font-weight: 700;
      font-stretch: normal;
      font-style: normal;
      line-height: 1;
      letter-spacing: normal;
      text-align: center;
      color: #ffffff;
    }

    .document-email-footer-container {
      display: inline-block;
      vertical-align: top;
      width: 600px;
      height: auto;
      font-size: 13px;
      font-weight: 400;
      font-stretch: normal;
      font-style: normal;
      line-height: 1.46;
      letter-spacing: normal;
      color: #686d76;
      background-color: #ffffff;
      padding: 40px 0;
    }

    .document-email-footer-1 {
      display: inline-block;
      vertical-align: top;
    }

    .document-email-footer-2 {
      display: inline-block;
      vertical-align: top;
      margin-top: 5px;
    }

    .email-text-strong {
      font-weight: 800;
    }

    .document-expire-background {
      background-color: #ffeebb;
    }

    .document-cancel-background {
      background-color: #ffd7d7;
    }

    .document-reject-background {
      background-color: #ffd7d7;
    }

    .document-forward-background {
      background-color: #e0e9ff;
    }

    .width-100 {
      width: 100px;
    }

    .width-110 {
      width: 110px;
    }

    .width-120 {
      width: 120px;
    }

    .width-130 {
      width: 130px;
    }

    .width-140 {
      width: 140px;
    }

    .width-150 {
      width: 150px;
    }

    .width-160 {
      width: 160px;
    }

    .width-170 {
      width: 170px;
    }

    .width-180 {
      width: 180px;
    }

    .width-190 {
      width: 190px;
    }

    .width-200 {
      width: 200px;
    }

  </style>
</head>

<body th:inline="text">
<div class="email-content">
  <div class="email-top-section">
    <div class="email-header">
      <a href="${homeUrl}" class="email-header-logo" target="_blank">
        <img class="logo logo-margin"
             src="https://instsign-resource.s3.ap-northeast-2.amazonaws.com/email/images/instsign-logo-107-x-15@2x.png" />
      </a>
      <a href="${documentUrl}" target="_blank1">
        <div class="email-header-link-button">
          <span>${msg("myDocumentButton")?no_esc}</span>
        </div>
      </a>
    </div>
    <div class="email-title">
      <div class="email-title-1">
        <span>${msg("emailPasswordResetTitle","${name}")?no_esc}</span>
      </div>
    </div>
    <div class="email-subtitle">
      <div class="email-subtitle-1">
        <span>${msg("emailPasswordResetSubtitle")?no_esc}</span>
      </div>
    </div>
    <div class="email-button-container width-130">
      <a href="${mainButtonUrl}"
         target="_blank2">
        <div class="email-main-button">
          <span>${msg("emailPasswordResetButton")?no_esc}</span>
        </div>
      </a>
    </div>
  </div>
  <div class="document-email-footer-container">
    <p class="document-email-footer-1">
      <span>${msg("emailPasswordResetFooter")?no_esc}</span>
    </p>
  </div>
</div>
</body>
</html>