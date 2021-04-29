*** Settings ***
Suite Setup       init test env sync    live
Test Setup        before test    live
Test Teardown     after test
Library           SeleniumLibrary    #Test Teardown    after test
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
    [Template]    Dang nhap Account
    ${google_account}    ${google_pass}

ACC002
    [Template]    Update profile
    nguyen van a    10/10/2000

ACC004
    [Template]    Click yeu thich san pham va kiem tra
    1    2    3    4    5

*** Keywords ***
Dang nhap Account
    [Arguments]    ${email}    ${pass}
    click to element    ${btn_taikhoan}
    click to element    ${link_dangnhap}
    sendkey to element    ${txt_mailaccount}    ${email}
    click element js    ${btn_next}
    sendkey to element    ${txt_passaccount}    ${pass}
    click element js    ${btn_next}

Update profile
    [Arguments]    ${name}    ${date_of_birth}
    Dang nhap account    ${google_account}    ${google_pass}
    Click to element    ${acc_infor}
    Click to element    ${link_profile}
    Sendkey to element    ${txt_nameacc}    ${name}
    Click to element    ${radiobt_nu}
    Sendkey to element    ${txt_dateofbirth}    ${date_of_birth}
    Click to element    ${btn_luu}

Click yeu thich san pham va kiem tra
    [Arguments]    ${stt1}    ${stt2}    ${stt3}    ${stt4}    ${stt5}
    Dang nhap account    ${google_account}    ${google_pass}
    ${statuss}=    run keyword and return status    wait until element is visible    ${btn_activeiconlove}    10s
    run keyword if    '${statuss}'=='True'    Click off sp active icon love    ${stt1}    ${stt2}    ${stt3}    ${stt4}
    ...    ${stt5}
    ...    ELSE    Click on active sp icon love    ${stt1}    ${stt2}    ${stt3}    ${stt4}
    ...    ${stt5}

Click on active sp icon love
    [Arguments]    ${stt1}    ${stt2}    ${stt3}    ${stt4}    ${stt5}
    : FOR    ${INDEX}    IN    ${stt1}    ${stt2}    ${stt3}    ${stt4}
    ...    ${stt5}
    \    ${btn_stticonlove}    format string    ${btn_iconlove}    ${INDEX}
    \    ${text_stttensplove}    format string    ${txt_tensplove}    ${INDEX}
    \    wait until element is visible    ${btn_stticonlove}    10s
    \    scroll element into view    ${btn_stticonlove}
    \    Click To Element    ${btn_stticonlove}
    \    ${tensplove}    get text    ${text_stttensplove}
    \    ${tensp}    Get customer favorite products from api    736403
    \    should be equal as strings    ${tensp}    ${tensplove}
    \    EXIT FOR LOOP IF    '${INDEX}'=='5'

Click off sp active icon love
    [Arguments]    ${stt1}    ${stt2}    ${stt3}    ${stt4}    ${stt5}
    : FOR    ${INDEX}    IN    ${stt1}    ${stt2}    ${stt3}    ${stt4}
    ...    ${stt5}
    \    ${btn_stticonlove}    format string    ${btn_iconlove}    ${INDEX}
    \    ${text_stttensplove}    format string    ${txt_tensplove}    ${INDEX}
    \    wait until element is visible    ${btn_stticonlove}    10s
    \    scroll element into view    ${btn_stticonlove}
    \    Click To Element    ${btn_stticonlove}
    \    EXIT FOR LOOP IF    '${INDEX}'=='5'
