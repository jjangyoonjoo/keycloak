package org.keycloak.utils;

import org.keycloak.broker.provider.BrokeredIdentityContext;

import java.util.Arrays;
import java.util.List;

public class IdentityProviderUtils {

  public static final List<String> KOREAN_LAST_NAMES_GREATER_THAN_ONE_LETTER = Arrays.asList("남궁", "동방", "무본", "서문", "선우", "어금", "제갈", "황목", "황보");

  public static void setName(BrokeredIdentityContext user , String inputName) {
      boolean foundMatchingLastName = false;
      for (String temp : KOREAN_LAST_NAMES_GREATER_THAN_ONE_LETTER) {
        if (inputName.startsWith(temp)) {
          user.setLastName(temp);
          user.setFirstName(inputName.substring(temp.length()));
          foundMatchingLastName = true;
          break;
        }
      }
      if (!foundMatchingLastName){
        user.setName(inputName);
      }
  }
}
