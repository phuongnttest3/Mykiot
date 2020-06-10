*** Settings ***
Library           String
Library           StringFormat
Library           DateTime
Library           Collections
Library           SeleniumLibrary

*** Keywords ***
Type in field
    [Arguments]    ${locator}    ${text}
    [Documentation]    write text letter by letter
    ${items}    Get Length    ${text}
    : FOR    ${item}    IN RANGE    0    ${items}
    \    Log    ${text[${item}]}
    \    Press Key    ${locator}    ${text[${item}]}
