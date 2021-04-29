*** Settings ***
Suite Setup       init test env    stagingnew
Suite Teardown
Test Teardown     after test
Library           SeleniumLibrary
Library           Collections
Library           RequestsLibrary
Library           JSONLibrary
Library           StringFormat
Resource          ../Config/Env/envi.robot
Resource          ../Core/API/api_access.robot
Resource          ../Core/PageBuilder/PageBuilder_locator.robot
Resource          ../Core/PageBuilder/data_pagebuilder.robot
Resource          ../Core/PageBuilder/pagebuilder_action.robot
Resource          ../Core/Common.robot
Resource          ../Core/SearchResult_Page/Searchpage_locator.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/Homepage/Homepage_action.robot
Resource          ../Core/Homepage/Homepage_locator.robot
Resource          ../Core/API/api_access_myk.robot

*** Test Cases ***
TC019
    [Tags]    all    pagebuilder
    [Template]    Update banner display to slider
    ${data_001}

TC020
    [Tags]    all    pagebuilder    test
    [Template]    Update banner display to grid
    ${data_002}

TC021
    [Tags]    all    pagebuilder
    [Template]    Update product list to display 2 columns
    ${data_003}

TC022
    [Tags]    all    pagebuilder
    [Template]    Update product list to display 3 columns
    ${data_004}

TC023
    [Tags]    all    pagebuilder
    [Template]    Update product list to display 4 columns
    ${data_005}

TC024
    [Tags]    all    pagebuilder
    [Template]    Update product list to display 5 columns
    ${data_006}

TC025
    [Tags]    all    pagebuilder
    [Template]    Update product list to display 6 columns
    ${data_007}

TC026
    [Tags]    all    pagebuilder
    [Template]    Update product list to manual load
    ${data008}

TC027
    [Tags]    all    pagebuilder
    [Template]    Update product list to autoload
    ${data_009}

TC028
    [Tags]    all    pagebuilder
    [Template]    Update product list to have sidebar
    ${data010}

TC029
    [Tags]    all    pagebuilder
    [Template]    Update product list to have no sidebar
    ${data011}

TC030
    [Tags]    all    pagebuilder
    [Template]    Update product detail to display Warehouse
    ${data_012}    SP000144

TC031
    [Tags]    all    pagebuilder
    [Template]    Update product detail to not display Warehouse
    ${data_013}    SP000144

TC032
    [Tags]    all    pagebuilder
    [Template]    Update product detail to display Product Description
    ${data_014}    SP000144

TC033
    [Tags]    all    pagebuilder
    [Template]    Update product detail to not display Product Description
    ${data_015}    SP000144

TC034
    [Tags]    all    pagebuilder
    [Template]    Update product detail to display comment
    ${data_016}    SP000144

TC035
    [Tags]    all    pagebuilder
    [Template]    Update product detail to not display comment
    ${data_017}    SP000144

TC036
    [Tags]    all    pagebuilder
    [Template]    Update product detail to display related product
    ${data_018}    SP000144

TC037
    [Tags]    all    pagebuilder
    [Template]    Update product detail to not display related product
    ${data_019}    SP000144

*** Keywords ***
Update banner display to slider
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlaptrangchu}
    click to element    ${btn_bannerads}
    select frame    ${ifr_pagebuilder}
    page should contain element    ${img_banner_slider}    #dang truot
    go to    ${storefront_url}
    sleep    2s
    page should contain element    ${img_banner_slider}

Update banner display to grid
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlaptrangchu}
    click to element    ${btn_bannerads}
    select frame    ${ifr_pagebuilder}
    page should contain element    ${img_banner_grid}    #dang luoi
    go to    ${storefront_url}
    page should contain element    ${img_banner_grid}

Update product list to display 2 columns
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_2column}    5s
    page should contain element    ${item_sp_2column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_2column}

Update product list to display 3 columns
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_3column}    5s
    page should contain element    ${item_sp_3column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_3column}

Update product list to display 4 columns
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_4column}    5s
    page should contain element    ${item_sp_4column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_4column}

Update product list to display 5 columns
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_5column}    5s
    page should contain element    ${item_sp_5column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_5column}

Update product list to display 6 columns
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_6column}    5s
    page should contain element    ${item_sp_6column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_6column}

Update product list to manual load
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    scroll element into view    ${lblfooter}
    page should contain element    ${btn_taithucong}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    scroll element into view    ${lblfooter}
    page should contain element    ${btn_taithucong}

Update product list to autoload
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    #scroll element into view    ${lblfooter}
    page should not contain element    ${btn_taithucong}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should not contain element    ${btn_taithucong}

Update product list to have sidebar
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    #scroll element into view    ${lblfooter}
    page should contain element    ${item_sidebar}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sidebar}

Update product list to have no sidebar
    [Arguments]    ${data}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapdanhsachsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${item_sidebar}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should not contain element    ${item_sidebar}

Update product detail to display Warehouse
    [Arguments]    ${data}    ${input_text}
    [Tags]    all    pagebuilder
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    #sleep    5s
    #select frame    ${ifr_pagebuilder}
    #page should contain element    ${lbl_thongtinkhohang}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    Click element    ${link_sp}
    wait until element is visible    ${lbl_thongtinkhohang}
    page should contain element    ${lbl_thongtinkhohang}

Update product detail to not display Warehouse
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_thongtinkhohang}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    Click element    ${link_sp}
    Sleep    3s
    page should not contain element    ${lbl_thongtinkhohang}

Update product detail to display Product Description
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_motasp}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    click to element    ${link_sp}
    wait until element is visible    ${lbl_motasp}
    page should contain element    ${lbl_motasp}

Update product detail to not display Product Description
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_motasp}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    click to element    ${link_sp}
    sleep    3s
    page should not contain element    ${lbl_motasp}

Update product detail to display comment
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_danhgiasp}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    Click to element    ${link_sp}
    wait until element is visible    ${lbl_thongtinkhohang}
    page should contain element    ${lbl_danhgiasp}

Update product detail to not display comment
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_danhgiasp}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    click to element    ${link_sp}
    wait until element is visible    ${lbl_thongtinkhohang}
    page should not contain element    ${lbl_danhgiasp}

Update product detail to display related product
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_hanghoacungloai}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    click to element    ${link_sp}
    wait until element is visible    ${lbl_thongtinkhohang}
    page should contain element    ${lbl_hanghoacungloai}

Update product detail to not display related product
    [Arguments]    ${data}    ${input_text}
    ${datanew}    Format string    ${data}    ${retailer_id}
    post request and validate request success    /config/save    ${datanew}
    go to pagebuilder
    click to element    ${menu_thietlapchitietsp}
    sleep    2s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_hanghoacungloai}
    go to    ${storefront_url}
    sleep    3s
    Tim kiem san pham    ${input_text}
    click to element    ${link_sp}
    wait until element is visible    ${lbl_thongtinkhohang}
    page should not contain element    ${lbl_hanghoacungloai}
