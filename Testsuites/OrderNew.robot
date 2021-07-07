*** Settings ***
Suite Setup       init test storefront    stagingtest
Suite Teardown
Test Teardown     after test
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           OperatingSystem
Resource          ../Config/Env/envi.robot
Resource          ../Core/Common.robot
Resource          ../Core/Share/Computation.robot