*** Settings ***
Library           SeleniumLibrary
Resource          ../Config/Env/envi.robot
Resource          PageBuilder/data_pagebuilder.robot

*** Keywords ***
before test
    [Arguments]    ${env}
    fill env    ${env}
    open browser    ${storefront_url}    chrome
    Maximize browser window

after test
    close browser

after test page builder
    post request and validate request success    /config/save    ${data_reset}
