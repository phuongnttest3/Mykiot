*** Settings ***
Test Setup        before test    prelive
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
Resource          ../Core/ProductCategoryList_Page/ProductCategoryList_action.robot

*** Variables ***
&{order_1}        SP000006=3    SP000007=4    SP000009=3

*** Test Cases ***
TC001
    [Tags]    All    Order
    [Template]    Them san pham noi bat vao cart va thanh toan
    phuong    0339786605    4

TC002
    [Tags]    All    Order
    [Template]    Tao don hang voi san pham moi nhat
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    5

TC003
    [Tags]    All    Order
    [Template]    Them san pham cua category vao cart va thanh toan
    Huong Ha    0902100500    2

TC004
    [Tags]    All    Order
    [Template]    Them san pham noi bat vao cart thanh toan tai dia chi nguoi nhan
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    6

TC005
    [Tags]    All    Order
    [Template]    Tim kiem san pham va thanh toan
    áo thun    phuong    0987666555    phuong2610@gmail.com    434 TKC    As soon as possible    3

TC006
    [Tags]    All    Order
    [Template]    them sp vao cart, cap nhat sl va thanh toan
    phuong    0339786605    4    5

TC007
    [Tags]    All    Order
    [Template]    Tao don hang voi nhieu san pham
    ${order_1}    phuong    0987666444

TC008
    [Tags]    All    Order
    [Template]    chon sp vao quickcart
    2    Bang    0901200122

TC009
    [Tags]    All    Order
    [Template]    Chon san pham thuoc category dau tien vao cart va thanh toan
    3    Huong    0902100200

TC010
    [Tags]    All    Order
    [Template]    xem chi tiet va thanh toan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC011
    [Tags]    All    Order
    [Template]    Chon san pham thuoc category vao cart va thanh toan
    phuong    0987666555    phuong2610@gmail.com    434 TKC    As soon as possible    3

TC012
    [Tags]    All    Order
    [Template]    Cho sp vao don hang
    3    Le Huong    0902100200    huong@gmail.com    1B Yet Kieu    Don hang tao tu dong

TC013
    [Tags]    All    Order
    [Template]    Xem tat ca va thanh toan tai dia chi nguoi nhan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC014
    [Tags]    All    Order
    [Template]    cho hang hoa cung loai vao gio hang va thanh toan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC015
    [Tags]    All    Order
    [Template]    chon san pham thuoc tinh bien the vao cart va thanh toan
    áo phông dior    3    XL    đen    phuong    0987666555    phuong2610@gmail.com
    ...    434 TKC    As soon as possible

TC016
    [Tags]    All    Order
    [Template]    Bam da xem va cho vao gio
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC017
    [Tags]    All    Order
    [Template]    Bam yeu thich va cho vao gio hang
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

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
    ${thanhtien}    ${gia}    Them san pham moi nhat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Tao don hang voi nhieu san pham
    [Arguments]    ${dict_product_num}    ${ten}    ${sdt}
    ${tongtienhang}    ${list_thanhtien}    Tim kiem va add nhieu san pham vao cart    ${dict_product_num}
    Thanh toan nhieu san pham nhan hang tai chi nhanh    ${ten}    ${sdt}    ${list_thanhtien}    ${tongtienhang}

Them san pham cua category vao cart va thanh toan
    [Arguments]    ${user_name}    ${user_sdt}    ${sl}
    ${thanhtien}    ${gia}    Them san pham cua category vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Chon sp vao quickcart
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Chon sp mua ngay    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Xem tat ca va thanh toan tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem tat ca va them san pham vao cart    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Chon san pham thuoc category dau tien vao cart va thanh toan
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Xem chi tiet sp dau va them vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Chon san pham thuoc category vao cart va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    Chon category tu menu
    ${total}    ${price}    Them san pham cua trang category vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Cho sp vao don hang
    [Arguments]    ${sl}    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}
    ${thanhtien}    ${gia}    Cho sp vao gio hang    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Xem chi tiet va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem chi tiet va add vao cart    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Cho hang hoa cung loai vao gio hang va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem chi tiet va add hang hoa cung loai vao gio hang    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Chon san pham thuoc tinh bien the vao cart va thanh toan
    [Arguments]    ${input_text}    ${sl}    ${thuoctinh_1}    ${thuoctinh_2}    ${ten}    ${sdt}
    ...    ${diachi}    ${email}    ${ghichu}
    Tim kiem san pham    ${input_text}
    ${total}    ${price}    Chon san pham thuoc tinh vao cart    ${input_text}    ${sl}    ${thuoctinh_1}    ${thuoctinh_2}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Bam yeu thich va cho vao gio hang
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Bam yeu thich va add vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Bam da xem va cho vao gio
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Bam da xem va add cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}
