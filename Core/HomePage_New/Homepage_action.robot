*** Settings ***
Library           SeleniumLibrary
Resource          ../Share/Javascript.robot
Resource          ../Share/Dictionary.robot
Resource          ../Share/Computation.robot
Resource          Homepage_locator.robot

*** Keywords ***
Dang nhap account fe
    [Arguments]    ${email}    ${pass}
    click to element    ${btn_taikhoan}
    sleep  5s
    click to element    ${link_dangnhap}
    sendkey to element    ${txt_mailaccount}    ${email}
    click element js    ${btn_next}
    sendkey to element    ${txt_passaccount}    ${pass}
    click element js    ${btn_next}
