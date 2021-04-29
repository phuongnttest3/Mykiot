*** Settings ***
Suite Setup       init test env    stagingnew
Suite Teardown    after test pagebuilder
Test Teardown     after test
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../Core/Common.robot
Library           OperatingSystem
Resource          ../Core/API-KV/api_hanghoa_kv.robot
Resource          ../Core/API-KV/api_access_kv.robot
Resource          ../Core/Homepage/Homepage_locator.robot
Resource          ../Core/Homepage/Quickcart_locator.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/CMS-Product/productlist_locator.robot
Resource          ../Core/CMS-Product/productlist_action.robot
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
Resource          ../Core/CMS-Product/cms_locator.robot
Resource          ../Core/CMS-Product/cms_action.robot
Resource          ../Core/API/api_access_myk.robot

*** Variables ***

*** Test Cases ***
CMS001
    [Tags]    All    cms
    open all page at cms

CMS002
    [Tags]    All    cms
    [Template]    kiem tra hang hoa hien thi o storefront khi tat o cms
    SP001622

CMS003
    [Tags]    All    cms
    [Template]    check pagination page product
    5

CMS004
    [Tags]    All    cms
    [Template]    check so san pham hien thi tren trang danh sach hang hoa
    10    50

*** Keywords ***
open all page at cms
    open browser    ${access_url}    gc
    Maximize browser window
    title should be    Dashboard
    open page hanghoa
    open page baiviet
    open page donhang
    open page thietlap

kiem tra hang hoa hien thi o storefront khi tat o cms
    [Arguments]    ${product_code}
    open browser    ${access_url}    gc
    Maximize browser window
    title should be    Dashboard
    click to element    ${menu_hanghoa}
    title should be    Danh sách hàng hóa
    sendkey to element    ${txt_mahanghoa}    ${product_code}
    click to element    ${btn_loctimkiem}
    ${Status}=    Run Keyword And Return Status    Element Should Be Visible    ${btn_offproductactive}
    Run Keyword If    '${Status}'=='True'    click on product va kiem tra
    ...    ELSE    click off product va kiem tra

check pagination page product
    [Arguments]    ${page}
    open browser    ${access_url}    gc
    Maximize browser window
    title should be    Dashboard
    click to element    ${menu_hanghoa}
    title should be    Danh sách hàng hóa
    wait until element is visible    ${curentpage}    10s
    ${pagechoose}    format string    ${pagechoose}    ${page}
    click to element    ${pagechoose}
    ${pageactive1}    format string    ${pageactive}    ${page}
    wait until element is visible    ${pageactive1}    5s
    click to element    ${nextpage}
    ${next}=    set variable    1
    ${page1}    Evaluate    ${page}+${next}
    ${pageactive2}    format string    ${pageactive}    ${page1}
    wait until element is visible    ${pageactive2}    5s
    click to element    ${previouspage}
    ${pageactive}    format string    ${pageactive}    ${page}
    wait until element is visible    ${pageactive}    5s

check so san pham hien thi tren trang danh sach hang hoa
    [Arguments]    ${so_hanghoa}    ${new_hanghoa}
    open browser    ${access_url}    gc
    Maximize browser window
    title should be    Dashboard
    click to element    ${menu_hanghoa}
    title should be    Danh sách hàng hóa
    ${current_hanghoa1}    format string    ${current_hanghoa}    ${so_hanghoa}
    wait until element is visible    ${current_hanghoa1}    5s
    ${count}=    get element count    ${count_namesp}
    log to console    ${count}
    click to element    ${current_hanghoa1}
    click to element    ${sosp_hienthi}
    ${current_hanghoa2}    format string    ${current_hanghoa}    ${new_hanghoa}
    wait until element is visible    ${current_hanghoa2}    5s
    ${count}=    get element count    ${count_namesp}
    log to console    ${count}
