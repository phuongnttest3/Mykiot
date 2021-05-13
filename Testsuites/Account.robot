*** Settings ***
Suite Setup       init test env sync    stagingnew
Test Setup        before test    stagingnew
Test Teardown     after test
Library           SeleniumLibrary    #Test Teardown    after test
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           StringFormat
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
Resource          CoreAPI.robot

*** Test Cases ***
ACC001
    [Template]    Dang nhap Account
    ${google_account}    ${google_pass}

ACC002
    [Template]    Update profile
    nguyen van a    10/10/2000

ACC003
    [Template]    yeu thich san pham va kiem tra products favourite
    810060    SP000233

ACC004
    [Template]    Tao san pham và xem chi tiet kiem tra o products viewed
    Hàng hóa test    Hàng Mỹ    135000    62000    17


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
    ${name_1}=    Generate code automatically   ${name}
    Dang nhap account    ${google_account}    ${google_pass}
    Click to element    ${acc_infor}
    Click to element    ${link_profile}
    Sendkey to element    ${txt_nameacc}    ${name_1}
    Click to element    ${radiobt_nu}
    Sendkey to element    ${txt_dateofbirth}    ${date_of_birth}
    Click to element    ${btn_luu}

yeu thich san pham va kiem tra products favourite
    [Arguments]    ${retailer_id}    ${product_code}
    login customer get token from api    ${retailer_id}
    Dang nhap account    ${google_account}    ${google_pass}
    sendkey to element    ${txt_timkiem}    ${product_code}
    click element js    ${btn_timkiem}
    click to element    ${link_sp}
    click to element    ${icon_loveproduct_detail}
    ${ten_sp}    get text    ${lbl_productname_detail}
    ${tensp}    Get customer favorite products from api    ${retailer_id}
    should be equal as strings    ${ten_sp}    ${tensp}
    click to element    ${acc_infor}
    click to element    ${link_favourite}
    ${length}=    get length    ${tensp}
    : FOR    ${i}    IN RANGE    ${length}
    \    ${name}    get from list    ${tensp}    ${i}
    \    page should contain    ${name}
    \    Exit For Loop If    '${i}'=='${length}'

Tao san pham và xem chi tiet kiem tra o products viewed
    [Arguments]    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    ${product_code}    Generate code automatically    MYK
    Add kv product thr api    ${product_code}    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    sleep    59s
    Dang nhap account    ${google_account}    ${google_pass}
    sendkey to element    ${txt_timkiem}    ${product_code}
    click element js    ${btn_timkiem}
    click to element    ${link_sp}
    #click to element    ${icon_loveproduct_detail}
    ${ten_sp}    get text    ${lbl_productname_detail}
    click to element    ${acc_infor}
    click to element    ${link_productsviewed}
    page should contain    ${ten_sp}
