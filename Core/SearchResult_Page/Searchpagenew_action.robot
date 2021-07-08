*** Settings ***
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          Searchpage_locator.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../Common_/Common_locator.robot

*** Keywords ***
Them san pham tim kiem vao gio hang
    [Arguments]    ${key}    ${sl}
    sendkey to element    ${txt_searchfe}    ${key}
    press keys    ${txt_searchfe}    ENTER
    ${keysearch_visible}   format string    ${key_visible}   ${key}
    wait until element is visible  ${keysearch_visible}
    ${count}   get element count    ${item_size}
    should be true  '${count}' == '1'
    click to element    ${btn_icon_cart}
    ${tensp}    get text element   ${lbl_tensp}
    sendkey to element    ${txt_sl}    ${sl}
    ${price}    Convert price to number    ${lbl_giasp1}
    ${total}    Multiplication    ${price}    ${sl}
    click element js    ${btn_addtocartfe}
    click to element    ${btn_closefe}
    click to element    ${btn_checkout}
    return from keyword    ${tensp}    ${price}    ${total}
