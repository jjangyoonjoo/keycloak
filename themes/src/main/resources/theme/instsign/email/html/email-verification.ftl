<html>
<head>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet" type="text/css">
  <style type="text/css">
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }

    .custom-button-dnb {
      vertical-align: top;
      display: inline-block;
      width: auto;
      height: 52px;
      border-radius: 4px;
      background-color: #000021;
    }

    .custom-button-dnb-disabled {
      vertical-align: top;
      display: inline-block;
      width: auto;
      height: 52px;
      border-radius: 4px;
      background-color: #000021;
      opacity: 0.5;
    }

    .custom-button-dnb:hover {
      background-color: #404059;
    }

    .custom-button-dnb:active {
      background-color: #000019;
    }

    .custom-button-dnb span {
      width: 100%;
      height: 100%;
      text-align: center;
      font-size: 14px;
      font-weight: 500;
      padding: 0;
      color: #ffffff;
    }

    .custom-button-dnb-disabled span {
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 14px;
      font-weight: 500;
      padding: 0;
      color: #ffffff;
      opacity: 0.5;
    }

    .instsign-email-verfiy-main {
      height: 728px;
      background-color: #ffffff;
    }

    .instsign-email-verfiy-header {
      margin-top: 20px;
      margin-left: 24px;
      padding-top: 24px;
      padding-bottom: 24px;
      width: 640px;
      height: 20px;
      background-color: #ffffff;
    }

    .instsign-email-verfiy-header-img {
      width: 134px;
      height: 20px;
      object-fit: contain;
      background: url(https://app.instsign.com/content/images/email/instsign-dark.png) no-repeat center;
    }

    .instsign-email-verfiy-body {
      margin-top: 0;
      margin-left: 24px;
      width: 592px;
      height: 248px;
      border-radius: 4px;
      border: solid 2px rgba(0, 0, 33, 0.05);
      background-color: #fcfcfc;
    }

    .instsign-email-verfiy-body-title {
      margin-top: 56px;
      margin-left: 28px;
      margin-right: 28px;
      width: 536px;
      height: 36px;
      font-size: 24px;
      font-weight: normal;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      text-align: center;
      color: #000021;
    }

    .instsign-email-verfiy-body-subtitle {
      margin-top: 16px;
      margin-left: 28px;
      margin-right: 28px;
      width: 536px;
      height: 24px;
      font-size: 16px;
      font-weight: normal;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      text-align: center;
      color: #000021;
    }

    .instsign-email-verfiy-body-button {
      margin-top: 40px;
      margin-left: 216px;
      margin-right: 216px;
      width: 160px;
      text-decoration: none;
    }
    .instsign-email-verfiy-body-button-text{
      width: 100%;
      height: 100%;
      text-align: center;
      padding-top: 15px;
      padding-bottom: 17px;
    }

    .instsign-email-verfiy-footer {
      margin-top: 40px;
      margin-left: 24px;
      margin-right: 24px;
      width: 592px;
      height: 328px;
      background-color: #f6f6f6;
    }
    .instsign-email-verfiy-footer-title{
      padding-top: 24px;
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 18px;
      font-size: 12px;
      font-weight: 500;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      color: rgba(0, 0, 33, 0.65);
    }
    .instsign-email-verfiy-footer-sub1{
      padding-top: 16px;
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 18px;
      font-size: 12px;
      font-weight: 500;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      color: rgba(0, 0, 33, 0.65);
    }
    .instsign-email-verfiy-footer-sub1-1{
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 36px;
      font-size: 12px;
      font-weight: normal;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      color: rgba(0, 0, 33, 0.5);
    }
    .instsign-email-verfiy-footer-sub2{
      padding-top: 16px;
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 18px;
      font-size: 12px;
      font-weight: 500;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      color: rgba(0, 0, 33, 0.65);
    }
    .instsign-email-verfiy-footer-sub2-1{
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 36px;
      font-size: 12px;
      font-weight: normal;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      color: rgba(0, 0, 33, 0.5);
    }
    .instsign-email-verfiy-footer-copyright{
      padding-top: 80px;
      padding-left: 16px;
      padding-right: 16px;
      width: 560px;
      height: 16px;
      font-size: 13px;
      font-weight: normal;
      font-stretch: normal;
      font-style: normal;
      line-height: normal;
      letter-spacing: normal;
      text-align: center;
      color: rgba(0, 0, 33, 0.3);
    }
  </style>

</head>
<body>
${kcSanitize(msg("emailVerificationBodyHtml",link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration), user.firstName, user.lastName))?no_esc}
</body>
</html>
