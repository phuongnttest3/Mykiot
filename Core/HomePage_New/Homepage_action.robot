*** Settings ***
Library           SeleniumLibrary
Resource          Homepage_locator.robot
Resource          ../Share/Javascript.robot
Resource          ../Share/Dictionary.robot
Resource          ../Share/Computation.robot

*** Keywords ***
Dang nhap account
    [Arguments]    ${email}    ${pass}
    click to element    ${btn_taikhoan}
    click to element    ${link_dangnhap}
    sendkey to element    ${txt_mailaccount}    ${email}
    click element js    ${btn_next}
    sendkey to element    ${txt_passaccount}    ${pass}
    click element js    ${btn_next}
