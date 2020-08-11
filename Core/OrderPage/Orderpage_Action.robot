*** Settings ***
Resource          Orderpage_Locator.robot
Library           SeleniumLibrary
Library           StringFormat
Resource          ../Share/Javascript.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Dictionary.robot

*** Keywords ***
Thanh toan nhan hang tai chi nhanh
    [Arguments]    ${username}    ${mobilephone}    ${thanhtien}    ${gia}
    wait until element is visible    ${title_orderpage}
    ${giasp}    convert price to number    ${lbl_giasp_order}
    should be equal    ${giasp}    ${gia}
    scroll element into view    ${txt_name}
    wait until element is visible    ${txt_name}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${thanhtien}
    : FOR    ${time}    IN RANGE    5
    \    input text    ${txt_name}    ${username}
    \    input text    ${txt_mobilephone}    ${mobilephone}
    \    scroll element into view    ${lbl_footer}
    \    Click element    ${btn_thanhtoan}
    \    ${present}=    run keyword and return status    wait until element is visible    ${popup_msg}    5
    \    Exit for loop if    '${present}'=='True'
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click element js    ${btn_tieptucmuahang}

Thanh toan nhan hang tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${thanhtien}
    ...    ${gia}
    wait until element is visible    ${title_orderpage}
    ${giasp}    convert price to number    ${lbl_giasp_order}
    should be equal    ${giasp}    ${gia}
    set selenium speed    1s
    scroll element into view    ${lbl_footer}
    click element    ${cb_chinhanh}
    sleep    3s
    click element js    ${lb_giaohangtaidcnguoinhan}
    scroll element into view    ${txt_ten}
    set selenium speed    0.1s
    input text    ${txt_ten}    ${ten}
    input text    ${txt_sdt}    ${sdt}
    input text    ${txt_email}    ${email}
    input text    ${txt_diachi}    ${diachi}
    click element    ${cbb_thanhpho}
    ${thanhpho}    Format string    ${obj_thanhpho}    An Giang
    ${quanhuyen}    Format string    ${obj_quanhuyen}    Huyện An Phú
    ${phuongxa}    Format string    ${obj_phuongxa}    Thị trấn An Phú
    Click element    ${thanhpho}
    click element    ${cbb_quanhuyen}
    Click element    ${quanhuyen}
    Click element    ${cbb_phuongxa}
    Click element    ${phuongxa}
    input text    ${txa_ghichu}    ${ghichu}
    scroll element into view    ${btn_thanhtoan}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${thanhtien}
    click element js    ${btn_thanhtoan}
    wait until element is visible    ${popup_msg}
    ${messege}    get text    ${btn_tieptucmuahang}
    Should contain    ${messege}    TIẾP TỤC MUA HÀNG
    click element    ${btn_tieptucmuahang}

Cap nhat gio hang va thanh toan nhan hang tai chi nhanh
    [Arguments]    ${username}    ${mobilephone}    ${thanhtien}    ${gia}    ${sl_update}
    wait until element is visible    ${title_orderpage}
    ${giasp}    convert price to number    ${lbl_giasp_order}
    should be equal    ${giasp}    ${gia}
    input text    ${txt_sl}    ${sl_update}
    ${thanhtien1}    Multiplication    ${giasp}    ${sl_update}
    scroll element into view    ${txt_name}
    wait until element is visible    ${txt_name}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${thanhtien1}
    : FOR    ${time}    IN RANGE    5
    \    input text    ${txt_name}    phuong
    \    input text    ${txt_mobilephone}    0339678855
    \    scroll element into view    ${lbl_footer}
    \    Click element    ${btn_thanhtoan}
    \    ${present}=    run keyword and return status    wait until element is visible    ${popup_msg}    5
    \    Exit for loop if    '${present}'=='True'
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click element js    ${btn_tieptucmuahang}

Thanh toan nhieu san pham nhan hang tai chi nhanh
    [Arguments]    ${ten}    ${sdt}    ${list_thanhtien}    ${tongtienhang}
    wait until element is visible    ${title_orderpage}
    scroll element into view    ${txt_name}
    wait until element is visible    ${txt_name}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${tongtienhang}
    : FOR    ${time}    IN RANGE    5
    \    input text    ${txt_name}    ${ten}
    \    input text    ${txt_mobilephone}    ${sdt}
    \    scroll element into view    ${lbl_footer}
    \    Click element    ${btn_thanhtoan}
    \    ${present}=    run keyword and return status    wait until element is visible    ${popup_msg}    5
    \    Exit for loop if    '${present}'=='True'
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click element js    ${btn_tieptucmuahang}
