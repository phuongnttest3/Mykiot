*** Settings ***
Resource          ../../Core/API/api_access.robot
Library           StringFormat
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           pabot.PabotLib
Library           ArchiveLibrary
Resource          ../../Core/API-KV/api_access_kv.robot
Resource          ../../Core/API/api_core_customer.robot

*** Keywords ***
fill env
    [Arguments]    ${env}
    Log    ${env}
    ${dic_api_url}    Create Dictionary    live=https://admin.mykiot.vn/api    stagingnew=https://admin-staging.citigo.dev:40001/api    prelivenew=https://admin-prelive.citigo.dev:40003/api
    ${dic_url}    Create Dictionary    live=https://admin.mykiot.vn    stagingnew=https://admin-staging.citigo.dev:40001    prelivenew=https://admin-prelive.citigo.dev:40003
    ${dic_clientid}    Create Dictionary    live=1f36fe67-a0f2-453b-bea5-9d778218279c    stagingnew=c8b67155-4f9a-4ebe-80ee-cac6e18e8d44    prelivenew=c8b67155-4f9a-4ebe-80ee-cac6e18e8d44
    ${dic_secretkey}    Create Dictionary    live=5F16AD6044795B917F2F9E640F572EF835B71254    stagingnew=42C30C4FD5382D0A8153DE25BC3C637751A58FEB    prelivenew=42C30C4FD5382D0A8153DE25BC3C637751A58FEB
    ${dic_retailercode}    Create Dictionary    live=testautomykiot    stagingnew=testautomykiot    prelivenew=testautomykiot
    ${dic_retailerid}    Create Dictionary    live=737280    stagingnew=736403    prelivenew=736403
    ${dic_accessurl}    Create Dictionary    live=https://admin.mykiot.vn/connect?client_id=1f36fe67-a0f2-453b-bea5-9d778218279c&secret_key=5F16AD6044795B917F2F9E640F572EF835B71254&retailer_code=testautomykiot&retailer_id=737280    stagingnew=https://admin-staging.citigo.dev:40001/connect?client_id=c8b67155-4f9a-4ebe-80ee-cac6e18e8d44&secret_key=42C30C4FD5382D0A8153DE25BC3C637751A58FEB&retailer_code=testautomykiot&retailer_id=810060    prelivenew=https://admin-prelive.citigo.dev:40003/connect?client_id=c8b67155-4f9a-4ebe-80ee-cac6e18e8d44&secret_key=42C30C4FD5382D0A8153DE25BC3C637751A58FEB&retailer_code=testautomykiot&retailer_id=810060
    ${dic_storefronturl}    Create Dictionary    live=https://mykiot.vn/testautomykiot    stagingnew=https://staging.citigo.dev:40001/testautomykiot    prelivenew=https://prelive.citigo.dev:40003/testautomykiot
    ${dict_kvurl}    Create Dictionary    live=https://testautomykiot.kiotviet.com/    stagingnew=https://testautomykiot.kvpos.com:59903/    prelivenew=https://testautomykiot.kvpos.com:59903/
    ${dict_username}    Create Dictionary    live=admin    stagingnew=admin    prelivenew=admin
    ${dict_password}    Create Dictionary    live=123    stagingnew=123    prelivenew=123
    ${dic_kv_apiurl}    Create Dictionary    live=https://testautomykiot.kiotviet.com/api    stagingnew=https://testautomykiot.kvpos.com:59903/api    prelivenew=https://testautomykiot.kvpos.com:59903/api
    ${dic_branchid}    Create Dictionary    live=9113    stagingnew=9113    prelivenew=9113
    ${dic_zone}    Create Dictionary    live=26    stagingnew=1    prelivenew=1
    ${dic_salekvapi}    Create Dictionary    live=https://sale.kiotapi.com/api    stagingnew=https://kvpos.com:59309/api    prelivenew=https://kvpos.com:59309/api
    ${dic_google_account}    Create Dictionary    live=testautomation113@gmail.com    stagingnew=testautomation113@gmail.com    prelivenew=testautomation113@gmail.com
    ${dic_google_pass}    Create Dictionary    live=test@123456    stagingnew=test@123456    prelivenew=test@123456
    ${dic_customer_code_google_account}    Create Dictionary    live=KH3546BAC40    stagingnew=KHCA279ECD4    prelivenew=KHCA279ECD4
    ${dic_webhook_url}    Create Dictionary    live=http://webhook.mykiot.vn    stagingnew=https://queue-staging.citigo.dev:40001    prelivenew=https://queue-prelive.citigo.dev:40003
    ${api_url}    Get From Dictionary    ${dic_api_url}    ${env}
    ${url}    Get From Dictionary    ${dic_url}    ${env}
    ${client_id}    Get From Dictionary    ${dic_clientid}    ${env}
    ${secret_key}    Get From Dictionary    ${dic_secretkey}    ${env}
    ${retailer_code}    Get From Dictionary    ${dic_retailercode}    ${env}
    ${retailer_id}    Get From Dictionary    ${dic_retailerid}    ${env}
    ${access_url}    Get From Dictionary    ${dic_accessurl}    ${env}
    ${storefront_url}    Get From Dictionary    ${dic_storefronturl}    ${env}
    ${kv_url}    Get From Dictionary    ${dict_kvurl}    ${env}
    ${user_name}    Get From Dictionary    ${dict_username}    ${env}
    ${password}    Get From Dictionary    ${dict_password}    ${env}
    ${kvapi_url}    Get From Dictionary    ${dic_kv_apiurl}    ${env}
    ${branch_id}    Get From Dictionary    ${dic_branchid}    ${env}
    ${zone}    Get From Dictionary    ${dic_zone}    ${env}
    ${salekvapi}    Get From Dictionary    ${dic_salekvapi}    ${env}
    ${google_account}    Get From Dictionary    ${dic_google_account}    ${env}
    ${google_pass}    Get From Dictionary    ${dic_google_pass}    ${env}
    ${customer_code_google_account}    Get From Dictionary    ${dic_customer_code_google_account}    ${env}
    ${webhook_url}    Get From Dictionary    ${dic_webhook_url}    ${env}
    Set Global Variable    \${api_url}    ${api_url}
    Set Global Variable    \${url}    ${url}
    Set Global Variable    \${client_id}    ${client_id}
    Set Global Variable    \${secret_key}    ${secret_key}
    Set Global Variable    \${retailer_code}    ${retailer_code}
    Set Global Variable    \${retailer_id}    ${retailer_id}
    Set Global Variable    \${access_url}    ${access_url}
    Set Global Variable    \${storefront_url}    ${storefront_url}
    Set Global Variable    \${kv_url}    ${kv_url}
    Set Global Variable    \${user_name}    ${user_name}
    Set Global Variable    \${password}    ${password}
    Set Global Variable    \${kvapi_url}    ${kvapi_url}
    Set Global Variable    \${branch_id}    ${branch_id}
    Set Global Variable    \${zone}    ${zone}
    Set Global Variable    \${salekvapi}    ${salekvapi}
    Set Global Variable    \${google_account}    ${google_account}
    Set Global Variable    \${google_pass}    ${google_pass}
    Set Global Variable    \${customer_code_google_account}    ${customer_code_google_account}
    Set Global Variable    \${webhook_url}    ${webhook_url}

init test env
    [Arguments]    ${env}
    fill env    ${env}
    ${token_value}    get access token from api
    Set global variable    \${bearer_token_mykiot}    ${token_value}
    Append To Environment Variable    PATH    ${EXECDIR}${/}Drivers
    Set Screenshot Directory    ${EXECDIR}${/}Out${/}Failures
    Set Selenium Speed    0.1s

init test env sync
    [Arguments]    ${env}
    fill env    ${env}
    ${token_value}    ${resp.cookies}    Get BearerToken from api
    Set global variable    \${bearertoken}    ${token_value}
    Set global variable    \${resp.cookies}    ${resp.cookies}
    Append To Environment Variable    PATH    ${EXECDIR}${/}Drivers
    Set Screenshot Directory    ${EXECDIR}${/}Out${/}Failures
    Set Selenium Speed    0.1s

init test core api
    #fill env    ${env}
    ${token_value}    Login customer get token from api    259596
    Set global variable    \${bearer_token}    ${token_value}
    Append To Environment Variable    PATH    ${EXECDIR}${/}Drivers
    Set Screenshot Directory    ${EXECDIR}${/}Out${/}Failures
    Set Selenium Speed    0.1s
