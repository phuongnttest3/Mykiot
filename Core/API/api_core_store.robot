*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
Get data store from Api
    [Arguments]   ${store-info}
    ${params}=  create dictionary      store_info=${store-info}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/stores   params=${params}
    log  ${resp1.json()}
    ${data}=  JSONLibrary.Get Value From Json    ${resp1.json()}    $..data.sub_domain
    log   ${data}
    ${data1}=    evaluate    $data[0]
    log   ${data1}
    Should be equal as strings    ${data1}    ${store-info}
    Should be equal as strings    ${resp1.status_code}    200


Get config store from Api
    [Arguments]   ${store-id}
    ${header}=  create dictionary     Content-Type=application/json   store-id=${store-id}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/configs   headers=${header}
    Should be equal as strings    ${resp1.status_code}    200
    log  ${resp1.json()}

