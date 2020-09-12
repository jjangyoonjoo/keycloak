package org.keycloak.authentication.authenticators.findemail;

import org.jboss.logging.Logger;
import org.keycloak.Config;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.authentication.actiontoken.DefaultActionTokenKey;
import org.keycloak.authentication.authenticators.broker.AbstractIdpAuthenticator;
import org.keycloak.events.Details;
import org.keycloak.events.Errors;
import org.keycloak.events.EventBuilder;
import org.keycloak.models.*;
import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.services.messages.Messages;
import org.keycloak.services.validation.Validation;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.keycloak.services.validation.Validation.isMobilePhoneNumberValid;
import static org.keycloak.utils.IdentityProviderUtils.splitNames;
import static org.keycloak.utils.IdentityProviderUtils.stripMobilePhoneNumber;

public class FindEmailChooseUser implements Authenticator, AuthenticatorFactory {

    private static final Logger logger = Logger.getLogger(FindEmailChooseUser.class);

    public static final String PROVIDER_ID = "find-email-choose-user";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        String existingUserId = context.getAuthenticationSession().getAuthNote(AbstractIdpAuthenticator.EXISTING_USER_INFO);
        if (existingUserId != null) {
            UserModel existingUser = AbstractIdpAuthenticator.getExistingUser(context.getSession(), context.getRealm(), context.getAuthenticationSession());

            logger.debugf("Forget-password triggered when reauthenticating user after first broker login. Skipping reset-credential-choose-user screen and using user '%s' ", existingUser.getUsername());
            context.setUser(existingUser);
            context.success();
            return;
        }

        String actionTokenUserId = context.getAuthenticationSession().getAuthNote(DefaultActionTokenKey.ACTION_TOKEN_USER_ID);
        if (actionTokenUserId != null) {
            UserModel existingUser = context.getSession().users().getUserById(actionTokenUserId, context.getRealm());

            // Action token logics handles checks for user ID validity and user being enabled

            logger.debugf("Forget-password triggered when reauthenticating user after authentication via action token. Skipping reset-credential-choose-user screen and using user '%s' ", existingUser.getUsername());
            context.setUser(existingUser);
            context.success();
            return;
        }

        Response challenge = context.form().createFindEmail();
        context.challenge(challenge);
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        EventBuilder event = context.getEvent();
        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
        String name = formData.getFirst(Validation.FIELD_NAME);
        String mobilePhoneNumber = formData.getFirst(Validation.FIELD_MOBILE_PHONE_NUMBER);
        if (name == null || name.isEmpty()) {
            event.error(Errors.NAME_MISSING);
            Response challenge = context.form()
                .setError(Messages.MISSING_NAME)
                .createFindEmail();
            context.failureChallenge(AuthenticationFlowError.INVALID_USER, challenge);
            return;
        }
        if (mobilePhoneNumber == null || mobilePhoneNumber.isEmpty()) {
            event.error(Errors.MOBILE_PHONE_NUMBER_MISSING);
            Response challenge = context.form()
                .setError(Messages.MISSING_MOBILE_PHONE_NUMBER)
                .createFindEmail();
            context.failureChallenge(AuthenticationFlowError.INVALID_USER, challenge);
            return;
        }

        if (!isMobilePhoneNumberValid(mobilePhoneNumber)) {
            event.error(Errors.INVALID_MOBILE_PHONE_NUMBER);
            Response challenge = context.form()
                .setError(Messages.INVALID_MOBILE_PHONE_NUMBER)
                .createFindEmail();
            context.failureChallenge(AuthenticationFlowError.INVALID_USER, challenge);
            return;
        }

        name = name.trim();
        List<String> nameList = splitNames(name);
        mobilePhoneNumber = stripMobilePhoneNumber(mobilePhoneNumber);

        RealmModel realm = context.getRealm();
        Map<String, String> parameters = new HashMap<>();
        if (nameList.size() > 0) {
            parameters.put(UserModel.FIRST_NAME, nameList.get(0));
        }
        if (nameList.size() > 1) {
            parameters.put(UserModel.LAST_NAME, nameList.get(1));
        }
        parameters.put(UserModel.MOBILE_PHONE_NUMBER, mobilePhoneNumber);
        List<UserModel> userList = context.getSession().users().searchForUser(parameters, realm);
        UserModel user = null;
        if (userList != null && !userList.isEmpty()) {
            for (UserModel currentUser : userList) {
                List<String> valueList = currentUser.getAttribute(UserModel.MOBILE_PHONE_NUMBER);
                if (valueList != null && !valueList.isEmpty() && mobilePhoneNumber.equals(valueList.get(0))) {
                    user = currentUser;
                    break;
                }
            }
        }

//        context.getAuthenticationSession().setAuthNote(AbstractUsernameFormAuthenticator.ATTEMPTED_USERNAME, username);

        // we don't want people guessing usernames, so if there is a problem, just continue, but don't set the user
        // a null user will notify further executions, that this was a failure.

        if (user == null) {
            event.clone()
                .detail(Details.USERNAME, name)
                .error(Errors.USER_NOT_FOUND);
        } else if (!user.isEnabled()) {
            event.clone()
                .detail(Details.USERNAME, name)
                .user(user).error(Errors.USER_DISABLED);
        } else {
            context.setUser(user);
        }

        context.success();
    }

    @Override
    public boolean requiresUser() {
        return false;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {

    }

    @Override
    public String getDisplayType() {
        return "Choose User";
    }

    @Override
    public String getReferenceCategory() {
        return null;
    }

    @Override
    public boolean isConfigurable() {
        return false;
    }

    public static final AuthenticationExecutionModel.Requirement[] REQUIREMENT_CHOICES = {
        AuthenticationExecutionModel.Requirement.REQUIRED
    };

    @Override
    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return REQUIREMENT_CHOICES;
    }

    @Override
    public boolean isUserSetupAllowed() {
        return false;
    }

    @Override
    public String getHelpText() {
        return "Choose a user to find email for";
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return null;
    }

    @Override
    public void close() {

    }

    @Override
    public Authenticator create(KeycloakSession session) {
        return this;
    }

    @Override
    public void init(Config.Scope config) {

    }

    @Override
    public void postInit(KeycloakSessionFactory factory) {

    }

    @Override
    public String getId() {
        return PROVIDER_ID;
    }
}
