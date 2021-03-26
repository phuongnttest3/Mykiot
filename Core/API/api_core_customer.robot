*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
*** Keywords ***

Login customer get token from api
    [Arguments]   ${store-id}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded
    ${data}=   create dictionary    id=100593806776420832037     provider=google     name=Test Automaiton       email=testautomaiton@gmail.com
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  post request   lolo   v1/customers   headers=${heades1}   data=${data}
    log  ${resp1.json()}
    ${token}=  JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    ${token}=  evaluate  $token[0]
    log   ${token}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword   ${token}

Get profile customer from api
    [Arguments]   ${store-id}
    ${token}      Login customer get token from api   ${store-id}
    ${bearertoken}=   catenate   Bearer    ${token}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded   Authorization=${bearertoken}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/customers/profile   headers=${heades1}
    log  ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
  #  ${data1}=  JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
  #  ${data1}=  evaluate  $data1[0]
  #  log   ${data1}
  #  return from keyword   ${data1}
