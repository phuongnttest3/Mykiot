*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
before test
    open browser    https://www.mykiot.vn/testz5    chrome
    Maximize browser window

after test
    close browser
