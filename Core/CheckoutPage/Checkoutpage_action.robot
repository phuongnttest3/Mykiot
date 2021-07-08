*** Settings ***
Resource          Checkoutpage_locator.robot
Library           SeleniumLibrary
Library           StringFormat
Resource          ../Share/Javascript.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Dictionary.robot
Resource          ../Customer/Profilepage_locator.robot
Resource          ../Core/API/api_core_customer.robot
Resource          ../../Config/Env/envi.robot
Resource          ../Common_/Common_action.robot

*** Keywords ***
Thanh toan va nhan hang tai chi nhanh
    [Arguments]    ${tensp}    ${price}    ${total}
    #wait until element is visible    ${title_checkout}    5s
    ${name}    get text element    ${lbl_name}
    should be equal as strings    ${name}    ${tensp}
    ${giasp}    Convert price to number    ${lbl_gia}
    should be equal as numbers    ${price}    ${giasp}
    ${lbl_thanhtien}    Convert price to number    ${lbl_thanhtien}
    should be equal as numbers    ${lbl_thanhtien}    ${total}
    scroll element into view    ${total_thanhtoan}
    ${total_tt}    Convert price to number    ${total_thanhtoan}
    click to element    ${btn_dathang}
    ${order_code}    get text element    ${lblorder_code}
    click to element    ${btn_tieptucmuahang}
    return from keyword    ${order_code}    ${total_tt}

Thanh toan va nhan hang tai dia chi
    [Arguments]    ${tensp}    ${price}    ${total}    ${username}    ${phone}    ${diachi}
    ...    ${tinh_tp}    ${phuong_xa}
    ${name}    get text element    ${lbl_name}
    should be equal as strings    ${name}    ${tensp}
    ${giasp}    Convert price to number    ${lbl_gia}
    should be equal as numbers    ${price}    ${giasp}
    ${lbl_thanhtien}    Convert price to number    ${lbl_thanhtien}
    should be equal as numbers    ${lbl_thanhtien}    ${total}
    click to element    ${rb_nhantaidiachi}
    Tao dia chi moi    ${username}    ${phone}    ${diachi}    ${tinh_tp}    ${phuong_xa}
    sleep    2s
    page should contain    ${phone}    5s
    scroll element into view    ${total_thanhtoan}
    ${total_tt}    Convert price to number    ${total_thanhtoan}
    click to element    ${btn_dathang}
    ${order_code}    get text element    ${lblorder_code}
    click to element    ${btn_tieptucmuahang}
    return from keyword    ${order_code}    ${total_tt}

Chon chi nhanh nhan hang
    [Arguments]    ${brach_name}
    click to element    ${rb_nhantaichinhanh}
    ${chinhanh}    format string    ${rb_chinhanh}    ${brach_name}
    click to element    ${chinhanh}

Xoa dia chi
    ${json}    Get customer address from api
    ${list_id_address}=    JSONLibrary.Get Value From Json    ${json}    $.data[?(@.is_default==0)].id
    ${list_id_address}=    Evaluate    $list_id_address    modules=random, sys
    log    ${list_id_address}
    ${lengt_id_address}    get length    ${list_id_address}
    : FOR    ${i}    IN RANGE    ${lengt_id_address}
    \    ${item_id_address}    get from list    ${list_id_address}    ${i}
    \    Delete customer address from api    ${item_id_address}
    \    exit for loop if    '${i}' == '{list_id_address}'

Tao dia chi moi
    [Arguments]    ${username}    ${phone}    ${diachi}    ${tinh_tp}    ${phuong_xa}
    click to element    ${btn_update_address}
    click to element    ${btn_create_address}
    sendkey to element    ${txt_name}    ${username}
    sendkey to element    ${txt_phone}    ${phone}
    sendkey to element    ${txt_address}    ${diachi}
    wait until element is visible    ${dropdown_tinh_tp}    5s
    sendkey to element    ${dropdown_tinh_tp}    ${tinh_tp}
    press keys    ${dropdown_tinh_tp}    ENTER
    wait until element is visible    ${dropdown_phuong_xa}    5s
    sendkey to element    ${dropdown_phuong_xa}    ${phuong_xa}
    press keys    ${dropdown_phuong_xa}    ENTER
    click element js    ${chbox_default_address}
    click to element    ${btn_luu_address}
