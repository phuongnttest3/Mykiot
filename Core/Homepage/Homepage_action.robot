*** Settings ***
Library           SeleniumLibrary
Resource          Homepage_locator.robot
Resource          Quickcart_locator.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot

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
