*** Settings ***
Library           SeleniumLibrary
Library           StringFormat

*** Variables ***
${mes_click}      document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
${mes_sendkey}    document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.send_keys('\n')
${mes_getvalue}    document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.return()

*** Keywords ***
Click Element JS
    [Arguments]    ${xpathElement}
    [Timeout]    15 seconds
    ${xpath}    Format String    ${mes_click}    ${xpathElement}
    Execute Javascript    ${xpath}

Sendkey JS
    [Arguments]    ${xpathElement}
    ${xpath}    Format String    ${mes_sendkey}    ${xpathElement}
    Execute Javascript    ${xpath}

Get value JS
    [Arguments]    ${xpathElement}
    ${xpath}    Format String    ${mes_getvalue}    ${xpathElement}
    Execute Javascript    ${xpath}

Get saved code after execute
    ${saved_code}    Execute Javascript    return window.document.getElementById('kvSavedCode').textContent;
    Return From Keyword    ${saved_code}
