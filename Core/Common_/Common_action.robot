*** Settings ***
Library           SeleniumLibrary
Resource          Common_locator.robot

*** Keywords ***
Tim kiem san pham
    [Arguments]    ${input_text}
    Wait until element is visible    ${txt_timkiem}
    input text    ${txt_timkiem}    ${input_text}
    Press key    ${txt_timkiem}    ENTER
