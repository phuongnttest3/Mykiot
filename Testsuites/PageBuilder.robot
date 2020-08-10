*** Settings ***
Suite Setup       init test env    staging
Suite Teardown    after test page builder
Test Teardown     after test
Library           SeleniumLibrary
Library           Collections
Library           RequestsLibrary
Library           JSONLibrary
Resource          ../Config/Env/envi.robot
Resource          ../Core/API/api_access.robot
Resource          ../Core/PageBuilder/PageBuilder_locator.robot
Resource          ../Core/PageBuilder/data_pagebuilder.robot
Resource          ../Core/PageBuilder/pagebuilder_action.robot
Resource          ../Core/Common.robot
Resource          ../Core/SearchResult_Page/Searchpage_locator.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/Homepage/Homepage_action.robot

*** Test Cases ***
TC019
    [Template]    Update banner display to slider
    ${data_001}

TC020
    [Template]    Update banner display to grid
    ${data_002}

TC021
    [Template]    Update product list to display 2 columns
    ${data_003}

TC022
    [Template]    Update product list to display 3 columns
    ${data_004}

TC023
    [Template]    Update product list to display 4 columns
    ${data_005}

TC024
    [Template]    Update product list to display 5 columns
    ${data_006}

TC025
    [Template]    Update product list to display 6 columns
    ${data_007}

TC026
    [Template]    Update product list to manual load
    ${data008}

TC027
    [Template]    Update product list to autoload
    ${data_009}

TC028
    [Template]    Update product list to have sidebar
    ${data010}

TC029
    [Template]    Update product list to have no sidebar
    ${data011}

TC030
    [Template]    Update product detail to display Warehouse
    ${data_012}

TC031
    [Template]    Update product detail to not display Warehouse
    ${data_013}

TC032
    [Template]    Update product detail to display Product Description
    ${data_014}

TC033
    [Template]    Update product detail to not display Product Description
    ${data_015}

TC034
    [Template]    Update product detail to display comment
    ${data_016}

TC035
    [Template]    Update product detail to not display comment
    ${data_017}

TC036
    [Template]    Update product detail to display related product
    ${data_018}

TC037
    [Template]    Update product detail to not display related product
    ${data_019}

*** Keywords ***
Update banner display to slider
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlaptrangchu}    5s
    click element    ${menu_thietlaptrangchu}
    select frame    ${ifr_pagebuilder}
    page should contain element    ${img_banner_slider}    #dang truot
    go to    ${storefront_url}
    page should contain element    ${img_banner_slider}

Update banner display to grid
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlaptrangchu}    5s
    click element    ${menu_thietlaptrangchu}
    select frame    ${ifr_pagebuilder}
    page should contain element    ${img_banner_grid}    #dang luoi
    go to    ${storefront_url}
    page should contain element    ${img_banner_grid}

Update product list to display 2 columns
    [Arguments]    ${data_003}
    post request and validate request success    /config/save    ${data_003}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_2column}    5s
    page should contain element    ${item_sp_2column}
    go to    ${storefront_url}
    sleep    3s
    Chon category tu menu
    page should contain element    ${item_sp_2column}

Update product list to display 3 columns
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_3column}    5s
    page should contain element    ${item_sp_3column}

Update product list to display 4 columns
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_4column}    5s
    page should contain element    ${item_sp_4column}

Update product list to display 5 columns
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_5column}    5s
    page should contain element    ${item_sp_5column}

Update product list to display 6 columns
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    wait until element is visible    ${item_sp_6column}    5s
    page should contain element    ${item_sp_6column}

Update product list to manual load
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    scroll element into view    ${lblfooter}
    page should contain element    ${btn_taithucong}

Update product list to autoload
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    #scroll element into view    ${lblfooter}
    page should not contain element    ${btn_taithucong}

Update product list to have sidebar
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    #scroll element into view    ${lblfooter}
    page should contain element    ${item_sidebar}

Update product list to have no sidebar
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapdanhsachsp}    5s
    click element    ${menu_thietlapdanhsachsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    #scroll element into view    ${lblfooter}
    page should not contain element    ${item_sidebar}

Update product detail to display Warehouse
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_thongtinkhohang}

Update product detail to not display Warehouse
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_thongtinkhohang}

Update product detail to display Product Description
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_motasp}

Update product detail to not display Product Description
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_motasp}

Update product detail to display comment
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_danhgiasp}

Update product detail to not display comment
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_danhgiasp}

Update product detail to display related product
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should contain element    ${lbl_hanghoacungloai}

Update product detail to not display related product
    [Arguments]    ${data}
    post request and validate request success    /config/save    ${data}
    go to pagebuilder
    wait until element is visible    ${menu_thietlapchitietsp}    5s
    click element    ${menu_thietlapchitietsp}
    sleep    5s
    select frame    ${ifr_pagebuilder}
    page should not contain element    ${lbl_hanghoacungloai}
