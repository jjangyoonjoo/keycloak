/*
 * Copyright 2017 Red Hat, Inc. and/or its affiliates
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
package org.keycloak.authentication.actiontoken.findemail;

import org.keycloak.TokenVerifier.Predicate;
import org.keycloak.authentication.AuthenticationProcessor;
import org.keycloak.authentication.actiontoken.AbstractActionTokenHander;
import org.keycloak.authentication.actiontoken.ActionTokenContext;
import org.keycloak.authentication.actiontoken.TokenUtils;
import org.keycloak.authentication.authenticators.broker.AbstractIdpAuthenticator;
import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.events.Errors;
import org.keycloak.events.EventType;
import org.keycloak.models.UserModel;
import org.keycloak.services.ErrorPage;
import org.keycloak.services.messages.Messages;
import org.keycloak.services.resources.LoginActionsService;
import org.keycloak.services.resources.LoginActionsServiceChecks.IsActionRequired;
import org.keycloak.sessions.CommonClientSessionModel.Action;

import javax.ws.rs.core.Response;

import static org.keycloak.services.resources.LoginActionsService.FIND_EMAIL_PATH;

/**
 *
 * @author hmlnarik
 */
public class FindEmailActionTokenHandler extends AbstractActionTokenHander<FindEmailActionToken> {

    public FindEmailActionTokenHandler() {
        super(
          FindEmailActionToken.TOKEN_TYPE,
          FindEmailActionToken.class,
          Messages.FIND_EMAIL_NOT_ALLOWED,
          EventType.FIND_EMAIL,
          Errors.NOT_ALLOWED
        );

    }

    @Override
    public Predicate<? super FindEmailActionToken>[] getVerifiers(ActionTokenContext<FindEmailActionToken> tokenContext) {
        return new Predicate[] {
            TokenUtils.checkThat(tokenContext.getRealm()::isResetPasswordAllowed, Errors.NOT_ALLOWED, Messages.RESET_CREDENTIAL_NOT_ALLOWED),

            new IsActionRequired(tokenContext, Action.AUTHENTICATE)
        };
    }

    @Override
    public Response handleToken(FindEmailActionToken token, ActionTokenContext tokenContext) {
        AuthenticationProcessor authProcessor = new FindEmailAuthenticationProcessor();

        return tokenContext.processFlow(
          false,
          FIND_EMAIL_PATH,
          tokenContext.getRealm().getFindEmailFlow(),
          null,
          authProcessor
        );
    }

    @Override
    public boolean canUseTokenRepeatedly(FindEmailActionToken token, ActionTokenContext tokenContext) {
        return false;
    }

    public static class FindEmailAuthenticationProcessor extends AuthenticationProcessor {

        @Override
        protected Response authenticationComplete() {
            boolean firstBrokerLoginInProgress = (authenticationSession.getAuthNote(AbstractIdpAuthenticator.BROKERED_CONTEXT_NOTE) != null);
            if (firstBrokerLoginInProgress) {

                UserModel linkingUser = AbstractIdpAuthenticator.getExistingUser(session, realm, authenticationSession);
                if (!linkingUser.getId().equals(authenticationSession.getAuthenticatedUser().getId())) {
                    return ErrorPage.error(session, authenticationSession, Response.Status.INTERNAL_SERVER_ERROR,
                      Messages.IDENTITY_PROVIDER_DIFFERENT_USER_MESSAGE,
                      authenticationSession.getAuthenticatedUser().getUsername(),
                      linkingUser.getUsername()
                    );
                }

                SerializedBrokeredIdentityContext serializedCtx = SerializedBrokeredIdentityContext.readFromAuthenticationSession(authenticationSession, AbstractIdpAuthenticator.BROKERED_CONTEXT_NOTE);
                authenticationSession.setAuthNote(AbstractIdpAuthenticator.FIRST_BROKER_LOGIN_SUCCESS, serializedCtx.getIdentityProviderId());

                logger.debugf("Forget-password flow finished when authenticated user '%s' after first broker login with identity provider '%s'.",
                        linkingUser.getUsername(), serializedCtx.getIdentityProviderId());

                return LoginActionsService.redirectToAfterBrokerLoginEndpoint(session, realm, uriInfo, authenticationSession, true);
            } else {
                return super.authenticationComplete();
            }
        }

    }
}
