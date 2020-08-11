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
Them san pham noi bat vao cart
    [Arguments]    ${sl}
    click element    ${btn_addtocart_spyeuthich}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Them san pham moi nhat vao cart
    [Arguments]    ${sl}
    click element    ${btn_addtocart_spmoi}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Tim kiem san pham
    [Arguments]    ${input_text}
    wait until element is visible    ${txt_timkiem}
    input text    ${txt_timkiem}    ${input_text}
    Click Element JS    ${btn_timkiem}

Them san pham hot vao cart
    [Arguments]    ${sl}
    click element    ${btn_addtocart_sp_hot}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Them san pham cua category vao cart
    [Arguments]    ${sl}
    scroll element into view    ${ctg_quick_cart}
    click element    ${ctg_quick_cart}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    click element    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Chon category tu menu
    click element    ${btn_danhmuchanghoa}
    wait until element is visible    ${link_category_menu}    3
    click element js    ${link_category_menu}

Xem tat ca va them san pham vao cart
    [Arguments]    ${sl}
    click element    ${xemtatca}
    wait until page contains element    ${icon_muahang_category}
    click element    ${icon_muahang_category}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet va add vao cart
    [Arguments]    ${sl}
    click element    ${detail}
    wait until page contains element    ${txt_soluong_detail}
    input text    ${txt_soluong_detail}    ${sl}
    ${price}    convert price to number    ${lbl_giasp_detail}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet va add hang hoa cung loai vao gio hang
    [Arguments]    ${sl}
    click element    ${detail}
    #sleep    3
    scroll element into view    ${lbl_footer}
    wait until page contains element    ${icon_muahang_hhcungloai}
    click element    ${icon_muahang_hhcungloai}
    wait until page contains element    ${btn_addtocart}
    sleep    3
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    sleep    3
    click element js    ${btn_addtocart_hhcungloai}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Xem chi tiet sp dau va them vao cart
    [Arguments]    ${sl}
    #execute javascript    window.scrollTo(0,1400)
    scroll element into view    ${detail}
    Click element    ${detail}
    sleep    3
    input text    ${txt_soluong_detail}    3
    Click button    ${quick_order}
    ${price}    convert price to number    ${lbl_giasp_detail}
    ${total}    Multiplication    ${price}    ${sl}
    Return from keyword    ${total}    ${price}

Bam yeu thich va add vao cart
    [Arguments]    ${sl}
    click element    ${icon_love}
    ${get_text}    Get text    ${lbl_tensp_hot}
    click element    ${icon_love_list}
    wait until page contains element    ${link_xemthem}
    click element    ${link_xemthem}
    ${get_text2}    Get text    ${lbl_tensp_love}
    should be equal    ${get_text}    ${get_text2}
    click element    ${icon_muahang_love}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Bam da xem va add cart
    [Arguments]    ${sl}
    wait until element isvisible    ${lbl_tensp_hot}
    ${get_text}    Get text    ${lbl_tensp_hot}
    click element    ${detail_hot}
    click element    ${logo}
    wait until element is visible    ${icon_view}
    click element    ${icon_view}
    wait until page contains element    ${link_xemthem}
    click element    ${link_xemthem}
    ${get_text2}    Get text    ${lbl_tensp_love}
    should be equal    ${get_text}    ${get_text2}
    click element    ${icon_muahang_love}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Chon sp mua ngay
    [Arguments]    ${sl}
    scroll element into view    ${ctg_quick_cart}
    click element    ${ctg_quick_cart}
    wait until page contains element    ${quick_order}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${quick_order}
    click element    ${btn_close}
    Return from keyword    ${total}    ${price}

Cho sp vao gio hang
    [Arguments]    ${sl}
    scroll element into view    ${link_danhmuc}
    #execute javascript    window.scrollTo(0,1300)
    Click element    ${link_danhmuc}
    sleep    3
    Click element    ${btn_addtocart_kqtk}
    wait until page contains element    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    click element    ${btn_addtocart}
    click element    ${btn_close}
    #wait until page contains element    ${btn_orderincart}
    #click element    ${btn_orderincart}
    #Return from keyword    ${total}    ${price}
    wait until page contains element    ${btn_orderincart}
    ${tongtien}    convert price to number    ${lbl_tongtienhang_cart}
    should be equal    ${total}    ${tongtien}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}
