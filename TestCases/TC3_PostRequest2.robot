*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    OperatingSystem
Library    REST

*** Variables ***
${baseurl}=  https://reqres.in/api
${Headers}=  {"Content-Type":"aplication/json",  "Accept":"aplication/json"}

*** Test Cases ***
PostTest
    Create Session    session1    ${baseurl}
    ${Body}=  create dictionary  email=sydney@fife
    ${Header}=  create dictionary  Content-Type=aplication/json
    Set Headers    ${Headers}
    ${response}=  POST On Session   session1   /register   json=${Body}  expected_status=400


    #validations
    ${status_code}=  Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  400
    ${content}=  Convert To String    ${response.content}
    ${json}  Convert String to JSON    ${content}
    Should Contain Any   ${content}  Missing password
    Output    ${content}
