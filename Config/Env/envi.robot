*** Settings ***
Resource          ../../Core/API/api_access.robot
Library           Collections
Library           RequestsLibrary

*** Keywords ***
fill env
    [Arguments]    ${env}
    Log    ${env}
    ${dic_api_url}    Create Dictionary    staging=https://admin.staging.citigo.dev/api    live=https://admin.mykiot.vn/api
    ${dic_url}    Create Dictionary    staging=https://admin.staging.citigo.dev    live=https://admin.mykiot.vn
    ${dic_clientid}    Create Dictionary    staging=1f36fe67-a0f2-453b-bea5-9d778218279c    live=1f36fe67-a0f2-453b-bea5-9d778218279c
    ${dic_secretkey}    Create Dictionary    staging=5F16AD6044795B917F2F9E640F572EF835B71254    live=5F16AD6044795B917F2F9E640F572EF835B71254
    ${dic_retailercode}    Create Dictionary    staging=testautomykiot    live=testautomykiot
    ${dic_retailerid}    Create Dictionary    staging=737280    live=737280
    ${dic_accessurl}    Create Dictionary    staging=https://admin.staging.citigo.dev/connect?client_id=1f36fe67-a0f2-453b-bea5-9d778218279c&secret_key=5F16AD6044795B917F2F9E640F572EF835B71254&retailer_code=testautomykiot&retailer_id=737280    live=https://admin.mykiot.vn/connect?client_id=1f36fe67-a0f2-453b-bea5-9d778218279c&secret_key=5F16AD6044795B917F2F9E640F572EF835B71254&retailer_code=testautomykiot&retailer_id=737280
    ${dic_storefronturl}    Create Dictionary    staging=https://staging.citigo.dev//testautomykiot    live=https://www.mykiot.vn/testautomykiot
    ${api_url}    Get From Dictionary    ${dic_api_url}    ${env}
    ${url}    Get From Dictionary    ${dic_url}    ${env}
    ${client_id}    Get From Dictionary    ${dic_clientid}    ${env}
    ${secret_key}    Get From Dictionary    ${dic_secretkey}    ${env}
    ${retailer_code}    Get From Dictionary    ${dic_retailercode}    ${env}
    ${retailer_id}    Get From Dictionary    ${dic_retailerid}    ${env}
    ${access_url}    Get From Dictionary    ${dic_accessurl}    ${env}
    ${storefront_url}    Get From Dictionary    ${dic_storefronturl}    ${env}
    Set Global Variable    \${api_url}    ${api_url}
    Set Global Variable    \${url}    ${url}
    Set Global Variable    \${client_id}    ${client_id}
    Set Global Variable    \${secret_key}    ${secret_key}
    Set Global Variable    \${retailer_code}    ${retailer_code}
    Set Global Variable    \${retailer_id}    ${retailer_id}
    Set Global Variable    \${access_url}    ${access_url}
    Set Global Variable    \${storefront_url}    ${storefront_url}

init test env
    [Arguments]    ${env}
    fill env    ${env}
    ${token_value}    get access token from api
    Set global variable    \${bearertoken}    ${token_value}
