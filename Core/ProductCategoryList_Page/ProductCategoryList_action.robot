*** Settings ***
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../Homepage/Homepage_locator.robot
Resource          ../SearchResult_Page/Searchpage_locator.robot

*** Keywords ***
Them san pham cua trang category vao cart
    [Arguments]    ${sl}
    sleep    5
    #wait until element is visible    ${msg_kqtimkiem}
    #${mes}=    Get text    ${msg_kqtimkiem}
    #Should contain any    ${mes}    ${input_text}
    Click Element JS    ${btn_addtocart_kqtk}
    wait until element is visible    ${btn_addtocart}
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    Click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}
