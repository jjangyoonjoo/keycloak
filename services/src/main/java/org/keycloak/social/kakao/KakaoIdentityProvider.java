/*
 * Copyright 2016 Red Hat, Inc. and/or its affiliates
 * and other contributors as indicated by the @author tags.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.keycloak.social.kakao;

import com.fasterxml.jackson.databind.JsonNode;
import org.keycloak.broker.oidc.AbstractOAuth2IdentityProvider;
import org.keycloak.broker.oidc.OAuth2IdentityProviderConfig;
import org.keycloak.broker.oidc.mappers.AbstractJsonUserAttributeMapper;
import org.keycloak.broker.provider.BrokeredIdentityContext;
import org.keycloak.broker.provider.IdentityBrokerException;
import org.keycloak.broker.provider.util.SimpleHttp;
import org.keycloak.broker.social.SocialIdentityProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.services.validation.Validation;
import org.keycloak.utils.IdentityProviderUtils;

import static org.keycloak.utils.IdentityProviderUtils.stripMobilePhoneNumber;

/**
 * @author <a href="mailto:yoonjoo.jang@gmail.com">YoonJoo jang</a>
 */
public class KakaoIdentityProvider extends AbstractOAuth2IdentityProvider implements SocialIdentityProvider {

    public static final String AUTH_URL = "https://kauth.kakao.com/oauth/authorize";
    public static final String TOKEN_URL = "https://kauth.kakao.com/oauth/token";
    public static final String PROFILE_URL = "https://kapi.kakao.com/v2/user/me";
    public static final String DEFAULT_SCOPE = "";

    public KakaoIdentityProvider(KeycloakSession session, OAuth2IdentityProviderConfig config) {
        super(session, config);
        config.setAuthorizationUrl(AUTH_URL);
        config.setTokenUrl(TOKEN_URL);
        config.setUserInfoUrl(PROFILE_URL);
    }

    protected BrokeredIdentityContext doGetFederatedIdentity(String accessToken) {
        try {
            JsonNode raw = SimpleHttp.doGet(PROFILE_URL, session).auth(accessToken).asJson();

            JsonNode account = raw.get("kakao_account");
            JsonNode profile = account.get("profile");

            logger.debug(raw.toString());
            logger.debug(account.toString());
            logger.debug(profile.toString());

            String id = getJsonProperty(raw, "id");

            BrokeredIdentityContext user = new BrokeredIdentityContext(id);

            String full_name = getJsonProperty(profile, "nickname");
            IdentityProviderUtils.setName(user, full_name);

            String email = getJsonProperty(account, "email");
            user.setEmail(email);
            user.setUsername(email);

            String phoneNumber = getJsonProperty(account, "phone_number");
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                phoneNumber = stripMobilePhoneNumber(phoneNumber);
                user.setUserAttribute(Validation.FIELD_MOBILE_PHONE_NUMBER, phoneNumber);
            }
            String birthYear = getJsonProperty(account, "birthyear");
            String birthDay = getJsonProperty(account, "birthday");
            if (birthYear != null && !birthYear.isEmpty() && birthDay != null && !birthDay.isEmpty()) {
                birthYear = birthYear.trim();
                birthDay = birthDay.trim();
                if (birthYear.length() == 4 && birthDay.length() == 4) {
                    String birthDate = birthYear + "/" + birthDay.substring(0, 2) + "/" + birthDay.substring(2);
                    user.setUserAttribute(Validation.FIELD_BIRTH_DATE, birthDate);
                }
            }
            String genderCode = getJsonProperty(account, "gender");
            if (genderCode != null && !genderCode.isEmpty()) {
                user.setUserAttribute(Validation.FIELD_GENDER_CODE, genderCode.trim());
            }
            String imageUrl = getJsonProperty(profile, "profile_image_url");
            if (imageUrl != null && !imageUrl.isEmpty()) {
                user.setUserAttribute(Validation.FIELD_PROFILE_IMAGE_URL, imageUrl.trim());
            }
            String thumbnailImageUrl = getJsonProperty(profile, "thumbnail_image_url");
            if (thumbnailImageUrl != null && !thumbnailImageUrl.isEmpty()) {
                user.setUserAttribute(Validation.FIELD_PROFILE_THUMBNAIL_IMAGE_URL, thumbnailImageUrl.trim());
            }

            user.setIdpConfig(getConfig());
            user.setIdp(this);

            AbstractJsonUserAttributeMapper.storeUserProfileForMapper(user, account, getConfig().getAlias());

            return user;
        } catch (Exception e) {
            throw new IdentityBrokerException("Could not obtain user profile from kakao.", e);
        }
    }

    @Override
    protected String getDefaultScopes() {
        return DEFAULT_SCOPE;
    }
}
