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
    sendkey to element    ${txt_name}    ${username}
    sendkey to element    ${txt_mobilephone}    ${mobilephone}
    scroll element into view    ${lbl_footer}
    click to element    ${btn_thanhtoan}
    wait until element is visible    ${btn_tieptucmuahang}    10
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click element    ${btn_tieptucmuahang}

Thanh toan nhan hang tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${thanhtien}
    ...    ${gia}
    wait until element is visible    ${title_orderpage}
    ${giasp}    convert price to number    ${lbl_giasp_order}
    should be equal    ${giasp}    ${gia}
    scroll element into view    ${lbl_footer}
    click to element    ${cb_chinhanh}
    wait until element is visible    ${lb_giaohangtaidcnguoinhan}
    click element js    ${lb_giaohangtaidcnguoinhan}
    scroll element into view    ${txt_ten}
    sendkey to element    ${txt_ten}    ${ten}
    sendkey to element    ${txt_sdt}    ${sdt}
    sendkey to element    ${txt_email}    ${email}
    sendkey to element    ${txt_diachi}    ${diachi}
    click to element    ${cbb_thanhpho}
    ${thanhpho}    Format string    ${obj_thanhpho}    An Giang - Huyện An Phú
    #${quanhuyen}    Format string    ${obj_quanhuyen}    Huyện An Phú
    ${phuongxa}    Format string    ${obj_phuongxa}    Thị trấn An Phú
    click to element    ${thanhpho}
    #click element    ${cbb_quanhuyen}
    #Click element    ${quanhuyen}
    click to element    ${cbb_phuongxa}
    click to element    ${phuongxa}
    sendkey to element    ${txa_ghichu}    ${ghichu}
    scroll element into view    ${btn_thanhtoan}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${thanhtien}
    wait until element is visible    ${btn_thanhtoan}    5s
    click element js    ${btn_thanhtoan}
    wait until element is visible    ${btn_tieptucmuahang}    5s
    ${messege}    get text    ${btn_tieptucmuahang}
    Should contain    ${messege}    TIẾP TỤC MUA HÀNG
    click to element    ${btn_tieptucmuahang}

Cap nhat gio hang va thanh toan nhan hang tai chi nhanh
    [Arguments]    ${username}    ${mobilephone}    ${thanhtien}    ${gia}    ${sl_update}
    wait until element is visible    ${title_orderpage}
    ${giasp}    convert price to number    ${lbl_giasp_order}
    should be equal    ${giasp}    ${gia}
    sendkey to element    ${txt_sl}    ${sl_update}
    ${thanhtien1}    Multiplication    ${giasp}    ${sl_update}
    scroll element into view    ${txt_name}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${thanhtien1}
    sendkey to element    ${txt_name}    phuong
    sendkey to element    ${txt_mobilephone}    0339678855
    scroll element into view    ${lbl_footer}
    click to element    ${btn_thanhtoan}
    wait until element is visible    ${btn_tieptucmuahang}    10s
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click to element    ${btn_tieptucmuahang}

Thanh toan nhieu san pham nhan hang tai chi nhanh
    [Arguments]    ${ten}    ${sdt}    ${list_thanhtien}    ${tongtienhang}
    wait until element is visible    ${title_orderpage}
    scroll element into view    ${txt_name}
    ${tongtien}    convert price to number    ${lbl_tongtienhang}
    Should be equal    ${tongtien}    ${tongtienhang}
    sleep    1s
    sendkey to element    ${txt_name}    ${ten}
    sendkey to element    ${txt_mobilephone}    ${sdt}
    scroll element into view    ${lbl_footer}
    Click to element    ${btn_thanhtoan}
    wait until element is visible    ${btn_tieptucmuahang}    10s
    ${messege}    get text    ${btn_tieptucmuahang}
    Should be equal as strings    ${messege}    TIẾP TỤC MUA HÀNG
    click to element    ${btn_tieptucmuahang}
