*** Settings ***
Library           SeleniumLibrary
Resource          Common_locator.robot

*** Keywords ***
Tim kiem san pham
    [Arguments]    ${input_text}
    Wait until element is visible    ${txt_searchfe}
    input text    ${txt_searchfe}    ${input_text}
    click element    ${btn_searchfe}
