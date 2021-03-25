*** Settings ***
Suite Setup       init test env sync    live
Test Setup        before test    live
Test Teardown     after test
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../Core/Common.robot
Library           OperatingSystem
Resource          ../Core/Homepage/Homepage_locator.robot
Resource          ../Core/Homepage/Quickcart_locator.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/OrderPage/Orderpage_Action.robot
Resource          ../Core/Share/Javascript.robot
Resource          ../Core/SearchResult_Page/Searchpage_locator.robot
Resource          ../Core/Homepage/Homepage_action.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/Share/Dictionary.robot
Resource          ../Core/SearchResult_Page/Searchpage_action.robot
Resource          ../Core/Share/Javascript.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/ProductCategoryList_Page/ProductCategoryList_action.robot
Resource          ../Core/API-KV/api_hoadon.robot
Resource          ../Core/API-KV/api_order_kv.robot
Resource          ../Core/Customer/Orderhistory_action.robot

*** Test Cases ***
ACC001
  [Template]   Dang nhap Account
  ${google_account}    ${google_pass}
ACC002
  [Template]   Cap nhat Profile
  nguyen van a    10/10/2000

*** Keywords ***
Dang nhap Account
    [Arguments]    ${email}   ${pass}
    click to element  ${btn_taikhoan}
    click to element  ${link_dangnhap}
    sendkey to element  ${txt_mailaccount}    ${email}
    click element js    ${btn_next}
    sendkey to element  ${txt_passaccount}    ${pass}
    click element js     ${btn_next}
Cap nhat Profile
    [Arguments]    ${name}    ${date_of_birth}
    Dang nhap account    ${google_account}    ${google_pass}
    Click to element    ${acc_infor}
    Click to element    ${link_profile}
    Sendkey to element    ${txt_nameacc}    ${name}
    Click to element    ${radiobt_nu}
    Sendkey to element    ${txt_dateofbirth}    ${date_of_birth}
    Click to element    ${btn_luu}
