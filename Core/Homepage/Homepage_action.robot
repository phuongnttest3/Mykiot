*** Settings ***
Library           SeleniumLibrary
Resource          Homepage_locator.robot
Resource          Quickcart_locator.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          ../OrderPage/Orderpage_Locator.robot

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

Add first product to cart
    [Arguments]    ${sl}
    scroll element into view    ${ctg_quick_cart}
    #execute javascript    window.scrollTo(0,1400)
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

Detail product
    [Arguments]    ${sl}
    execute javascript    window.scrollTo(0,1400)
    Click element    ${detail}
    input text    ${txt_soluong}    3
    Click button    ${quick_order}
    ${price}    convert price to number    ${gia_sp}
    ${total}    Multiplication    ${price}    ${sl}
    Return from keyword    ${total}    ${price}
