*** Settings ***
Test Setup        before test
Test Teardown
Library           SeleniumLibrary
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

*** Test Cases ***
TC001
    [Tags]    All    Order
    [Template]    Them san pham noi bat vao cart va thanh toan
    phuong    0339786605    4

TC004
    [Tags]    All    Order
    [Template]    them san pham noi bat vao cart thanh toan tai dia chi nguoi nhan
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    6

TC005
    [Tags]    All    Order
    [Template]    Tim kiem san pham va thanh toan
    áo thun    phuong    0987666555    phuong2610@gmail.com    434 TKC    As soon as possible    3

TC006
    [Tags]    All    Order
    [Template]    them sp vao cart, cap nhat sl va thanh toan
    phuong    0339786605    4    5

TC002
    [Template]    Tao don hang voi san pham moi nhat
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    5

TC003
    [Template]    Add first product to cart and order
    Huong Ha    0902100500    2

TC008

TC009
    [Template]    Detail product and order
    3    Huong    0902100200

TC011
    [Template]    Loc sp theo danh muc tu menu va dat hang
    3    Huong anh    09213654879

*** Keywords ***
Them san pham noi bat vao cart va thanh toan
    [Arguments]    ${username}    ${mobilephone}    ${sl}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${username}    ${mobilephone}    ${thanhtien}    ${gia}

Them san pham noi bat vao cart thanh toan tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Tim kiem san pham va thanh toan
    [Arguments]    ${input_text}    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}
    ...    ${sl}
    Tim kiem san pham    ${input_text}
    ${total}    ${price}    Them san pham tim kiem vao cart    ${input_text}    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Them sp vao cart, cap nhat sl va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${sl}    ${sl_update}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Cap nhat gio hang va thanh toan nhan hang tai chi nhanh    ${ten}    ${sdt}    ${thanhtien}    ${gia}    ${sl_update}

Tao don hang voi san pham moi nhat
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Them san pham hot vao cart    ${sl}
    sleep    ${sl}
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Add first product to cart and order
    [Arguments]    ${user_name}    ${user_sdt}    ${sl}
    ${thanhtien}    ${gia}    Add first product to cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Add products to cart
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Add first product to cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Detail product and order
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Detail product    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Loc sp theo danh muc tu menu va dat hang
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Loc sp loc trong danh muc vao quickcart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}
