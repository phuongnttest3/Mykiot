*** Settings ***
Library           SeleniumLibrary
Resource          ../Config/Env/envi.robot
Resource          PageBuilder/data_pagebuilder.robot
Resource          API-KV/api_hanghoa_kv.robot

*** Variables ***
@{list_sp_noibat_hot}    SP000200    SP000196    SP000233    SP000075

*** Keywords ***
before test
    [Arguments]    ${env}
    fill env    ${env}
    Append To Environment Variable    PATH    ${EXECDIR}${/}Drivers
    Set Screenshot Directory    ${EXECDIR}${/}Out${/}Failures
    open browser    ${storefront_url}    chrome
    Maximize browser window

after test
    close browser

after test page builder
    #post request and validate request success    /config/save    ${data_reset}
    ${datanew}    Format string    ${data_reset}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}

before test pagebuilder
    [Arguments]    ${env}
    init test env    ${env}
    init test env sync    ${env}
    ${productid_1}    Get product ID    @{list_sp_noibat_hot}[0]
    ${productid_2}    Get product ID    @{list_sp_noibat_hot}[1]
    ${productid_3}    Get product ID    @{list_sp_noibat_hot}[2]
    ${productid_4}    Get product ID    @{list_sp_noibat_hot}[3]
    ${data_forstart}    Format String    ${data_start}    ${productid_1}    ${productid_2}    ${productid_3}    ${productid_4}
    post request and validate request success    /config/save    ${data_forstart}
