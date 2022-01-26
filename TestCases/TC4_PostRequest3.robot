*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    OperatingSystem
Library    REST
Library    ../Resources/DateConverter.py

*** Variables ***
${baseurl}=  https://reqres.in/api
${Headers}=  {"Content-Type":"aplication/json",  "Accept":"aplication/json"}

*** Test Cases ***
PostTest
    Create Session    session1    ${baseurl}
    ${Body}  create dictionary  name=morpheus  job=leader  email=morpheus@gmail.com
    Set Headers    ${Headers}
    ${response}  POST On Session   session1   /users   json=${Body}

    #validations
    ${status_code}  Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  201

    ${content}  Convert To String   ${response.content}
    ${json}  Convert String to JSON    ${content}

    ${name}  Get Value From Json    ${json}  $.name
    Should Be Equal    ${name[0]}  morpheus

    ${job}  Get Value From Json    ${json}  $.job
    Should Be Equal    ${job[0]}    leader

    ${email}  Get Value From Json    ${json}  $.email
    Should Be Equal    ${email[0]}    morpheus@gmail.com

    Output    ${name[0]} is the ${job[0]} with email: ${email[0]}

    ${id}  Get Value From Json    ${json}  $.id
    ${idStr}    Convert To String    ${id[0]}
    ${idCount}  Get Length    ${idStr}
    ${idCountStr}  Convert To String    ${idCount}
    Should Be Equal    ${idCountStr}  3
    Output   ID has ${idCountStr} Digits

putRequest
    ${newBody}  create dictionary  name=david  email=david@gmail.com  job=leader
    Set Headers    ${Headers}
    ${response}  PUT On Session     session1  /users  json=${newBody}
    ${content}  Convert To String    ${response.content}
    ${json}  Convert String to JSON    ${content}


    #Validation
    ${name}  Get Value From Json    ${json}    $.name
    Should Be Equal    ${name[0]}    david
    ${email}  Get Value From Json    ${json}    $.email
    Should Be Equal    ${email[0]}    david@gmail.com

    #timeConvertion
    ${updatedTime}  Get Value From Json    ${json}  $.updatedAt
    ${persianDate}  G 2 P    ${updatedTime}
    ${time}  Spliter    ${updatedTime}
    ${dateTime}  Convert To String    ${persianDate}T${time}
    Output    ${json}
    Output    ${dateTime}