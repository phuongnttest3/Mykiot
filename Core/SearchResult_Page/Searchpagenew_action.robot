*** Settings ***
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          Searchpage_locator.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../HomePage_New/Homepage_locator.robot
Resource          ../Common_/Common_locator.robot

*** Keywords ***
Them san pham tim kiem vao gio hang
    [Arguments]    ${key}    ${sl}
    sendkey to element    ${txt_searchfe}    ${key}
    sleep    3s
    press keys    ${txt_searchfe}    ENTER
    sleep    2s
    click to element    ${btn_icon_cart}
    ${tensp}    get text    ${lbl_tensp}
    sleep  2s
    sendkey to element    ${txt_sl}    ${sl}
    ${price}    Convert price to number    ${lbl_giasp1}
    ${total}    Multiplication    ${price}    ${sl}
    #click element js    ${btn_addtocartfe}
    # click to element    ${btn_addtocart}
    # click to element    ${btn_closefe}
    click to element    ${btn_muahang}
    #click to element    ${btn_checkout}
    return from keyword    ${tensp}    ${price}    ${total}
