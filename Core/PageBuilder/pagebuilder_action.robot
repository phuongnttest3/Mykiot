*** Settings ***
Library           SeleniumLibrary
Resource          PageBuilder_locator.robot

*** Keywords ***
go to pagebuilder
    open browser    ${access_url}    gc
    Maximize browser window
    click to element    ${btn_tuybienhinhthuc}
