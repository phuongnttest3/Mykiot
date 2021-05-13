*** Settings ***
Library           SeleniumLibrary
Resource          Homepage_locator.robot
Resource          Quickcart_locator.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          ../SearchResult_Page/Searchpage_locator.robot
Resource          ../OrderPage/Orderpage_Locator.robot
Resource          ../Product Detail Page/Detail_locator.robot
Resource          ../Product Detail Page/Detail_locator.robot

*** Keywords ***
Dang nhap account
    [Arguments]    ${email}   ${pass}
    click to element  ${btn_taikhoan}
    click to element  ${link_dangnhap}
    sendkey to element  ${txt_mailaccount}    ${email}
    click element js    ${btn_next}
    sendkey to element  ${txt_passaccount}    ${pass}
    click element js     ${btn_next}

Them san pham noi bat vao cart
    [Arguments]    ${sl}
    click to element    ${btn_addtocart_spyeuthich}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Them san pham moi nhat vao cart
    [Arguments]    ${sl}
    click to element    ${btn_addtocart_spmoi}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Tim kiem san pham
    [Arguments]    ${input_text}
    sendkey to element    ${txt_timkiem}    ${input_text}
    click element js    ${btn_timkiem}

Them san pham hot vao cart
    [Arguments]    ${sl}
    click to element    ${txt_timkiem}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    wait until element is visible    ${btn_orderincart}    5s
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Them san pham cua category vao cart
    [Arguments]    ${sl}
    scroll element into view    ${ctg_quick_cart}
    click to element    ${ctg_quick_cart}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Chon category tu menu
    click to element    ${btn_danhmuchanghoa}
    wait until element is visible    ${link_category_menu}    5s
    click element js    ${link_category_menu}

Xem tat ca va them san pham vao cart
    [Arguments]    ${sl}
    click to element    ${xemtatca}
    click to element    ${icon_muahang_category}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet va add vao cart
    [Arguments]    ${sl}
    click to element    ${detail}
    sendkey to element    ${txt_soluong_detail}    ${sl}
    ${price}    convert price to number    ${lbl_giasp_detail}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet va add hang hoa cung loai vao gio hang
    [Arguments]    ${sl}
    click to element    ${detail}
    scroll element into view    ${lbl_footer}
    click to element    ${icon_muahang_hhcungloai}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart_hhcungloai}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet sp dau va them vao cart
    [Arguments]    ${sl}
    scroll element into view    ${detail}
    click to element    ${detail}
    sendkey to element    ${txt_soluong_detail}    ${sl}
    click to element    ${quick_order}
    ${price}    convert price to number    ${lbl_giasp_detail}
    ${total}    Multiplication    ${price}    ${sl}
    Return from keyword    ${total}    ${price}

Bam yeu thich va add vao cart
    [Arguments]    ${sl}
    click to element    ${icon_love}
    sleep    2s
    click to element    ${detail}
    ${get_text}    Get text    ${lbl_tensp_love}
    sleep    1s
    click to element    ${icon_love_list}
    click to element    ${link_xemthem}
    ${get_text2}    Get text    ${ten_list_viewlove}
    should be equal    ${get_text}    ${get_text2}
    click to element    ${icon_muahang_love}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Bam da xem va add cart
    [Arguments]    ${sl}
    scroll element into view    ${detail}
    click to element    ${detail}
    ${get_text}    Get text    ${lbl_tensp_love}
    click to element    ${logo}
    sleep    1s
    click to element    ${icon_view}
    click to element    ${link_xemthem}
    ${get_text2}    Get text    ${ten_list_viewlove}
    should be equal    ${get_text}    ${get_text2}
    click to element    ${icon_muahang_love}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Chon sp mua ngay
    [Arguments]    ${sl}
    scroll element into view    ${ctg_quick_cart}
    click to element    ${ctg_quick_cart}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${quick_order}
    #click to element    ${btn_close}
    Return from keyword    ${total}    ${price}

Cho sp vao gio hang
    [Arguments]    ${sl}
    scroll element into view    ${link_danhmuc}
    Click to element    ${link_danhmuc}
    Click to element    ${btn_addtocart_kqtk}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click to element    ${btn_addtocart}
    click to element    ${btn_close}
    wait until element is visible    ${lbl_tongtienhang_cart}    5s
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click to element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

kiem tra gio hang
     ${Status}=    Run Keyword And Return Status    wait until element is visible    ${slhh_incart}   5s
     Run Keyword If    '${Status}'=='False'    Xoa quickcart

Xoa quickcart
     click to element   ${cart_button}
     :FOR  ${index}  IN RANGE   100
     \  click to element   ${btn_xoacart}
     \  ${stus}=    Run Keyword And Return Status    wait until element is visible    ${slhh_incart}   5s
     \  exit for loop if     '${stus}'=='True'