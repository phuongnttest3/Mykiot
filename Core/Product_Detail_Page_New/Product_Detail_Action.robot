*** Settings ***
Library           String

*** Keywords ***
Get stock of product in product detail
    [Arguments]    ${dec}
    ${dec}    Convert To String    ${dec}
    ${dec}    Fetch from left    ${dec}    ${SPACE}
    #${dec}    Replace String    ${dec}    Sản phẩm có sẵn    ${EMPTY}
    ${dec}    Convert to number    ${dec}
    Return From Keyword    ${dec}

Get url product detail
    [Arguments]    ${name}    ${product_id}
    ${name1}    Convert To String    ${name}
    ${name1}    Replace String    ${name}    ${SPACE}    -
    ${word}    Catenate    SEPARATOR=    p    ${product_id}
    ${endpoint}    Catenate    SEPARATOR=.    ${name1}    ${word}    html
    ${url_product_detail}=    Catenate    SEPARATOR=/    https://fe-staging.citigo.dev:40001    ${endpoint}
    Return From Keyword    ${url_product_detail}
