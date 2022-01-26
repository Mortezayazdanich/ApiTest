*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    os
Library    Collections
Library    SeleniumLibrary
Library    REST

*** Variables ***
${base_url}=   https://gorest.co.in

*** Test Cases ***
GET Weather info
    create session  mysession  ${base_url}
    ${response}=  GET On Session  mysession   /public/v1/posts/123/comments


    ${json}=  Set Variable      ${response.json()}
    ${page}=  get value from json  ${json}  $.meta.pagination.page
    ${data}=  Get Value From Json    ${json}  $.data
    ${pagenum}=  Convert To String    ${page[0]}
    Should Be Equal    ${pagenum}  1
    ${dataContent}=  Convert To String    ${data[0]}
    Should Be Equal    ${dataContent}  []
    Output  ${json}
