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
Post Request of Register Demo Test
    Create Session    session1    ${baseurl}
    ${Body}=  create dictionary  name=morpheus  job=leader
    Set Headers    ${Headers}
    ${response}=  POST On Session   session1   /users   json=${Body}

    #validations
    ${status_code}=  Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  201

    ${content}=  Convert To String   ${response.content}
    ${json}=  Convert String to JSON    ${content}

    ${name}  Get Value From Json    ${json}  $.name
    Should Be Equal    ${name[0]}  morpheus

    ${job}  Get Value From Json    ${json}  $.job
    Should Be Equal    ${job[0]}    leader
    Output   ${name[0]} is the ${job[0]}

    ${id}=  Get Value From Json    ${json}  $.id
    ${idStr}    Convert To String    ${id[0]}
    ${idCount}  Get Length    ${idStr}
    ${idCountStr}  Convert To String    ${idCount}
    Should Be Equal    ${idCountStr}  3
    Output   ID ${idStr} has ${idCountStr} Digits

    #TimeConvertion
    ${createdTime}  Get Value From Json    ${json}  $.createdAt
    ${persianDate}  G 2 P    ${createdTime}
    ${time}  Spliter    ${createdTime}
    ${dateTime}  Convert To String    ${persianDate}T${time}
    Output    ${json}
    Output    ${dateTime}
