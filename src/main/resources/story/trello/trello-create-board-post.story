Description: Creates new board.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|key           |f450c2386460eb03cf8e92f7627e7824                                |
|token         |762ec2e16b5ae2598b5e7462e09f650b611025711f0c5d9c48b65389184837e2|
|member        |633eb9581af71f022637c947                                        |
|idOrganization|633eb98d82521c030733ee84                                        |

Scenario: Create a new board.
When I set request headers:
|name        |value           |
|Content-Type|application/json|
Given request body: {
    "name": "<boardName>",
    "key" : "<key>",
    "token": "<token>",
    "idOrganization": "<idOrganization>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/boards/`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|boardName                        |
|#{generate(regexify '[A-Z]{10}')}|

Scenario: Get boards that member belongs to.
When I execute HTTP GET request for resource with URL `${trello-endpoint}/1/members/<member>/boards?key=<key>&token=<token>`
When I save JSON element from context by JSON path `$[0]['id']` to STORY variable `boardId`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario:Update the board preferences. One request
When I set request headers:
|name        |value           |
|Content-Type|application/json|
Given request body: {
    "key" : "<key>",
    "token": "<token>",
    "value": "<value>"
}
When I execute HTTP PUT request for resource with URL `${trello-endpoint}<address>`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Then JSON element value from context by JSON path `<parameter>` is equal to `<value>`
Examples:
|address                                                                            |value|parameter                |
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/emailPosition          |top  |$.emailPosition          |
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/showListGuide          |true |$.showListGuide          |
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/showSidebar            |true |$.showSidebar            |
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/showSidebarActivity    |false|$.showSidebarActivity    |
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/showSidebarBoardActions|false|$.showSidebarBoardActions|
|/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/myPrefs/showSidebarMembers     |false|$.showSidebarMembers     |

Scenario: Update a first board
!-- mistake in description in Trello docs, "The new name for the board. 1 to 16384 characters long." Description 0 to 16384.
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<boardName>",
    "desc": "<boardDescription>",
    "key": "<key>",
    "token":"<token>",
    "idOrganization": "<idOrganization>"
}
When I execute HTTP PUT request for resource with URL `${trello-endpoint}/1/boards/#{removeWrappingDoubleQuotes(${boardId})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|boardName                         |boardDescription                  |
|#{generate(regexify '[A-Z]{999}')}|#{generate(regexify '[a-z]{999}')}|

Scenario: Create boards with different lengths of name and description.
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<boardName>",
    "desc": "<boardDescription>",
    "idOrganization": "<idOrganization>",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP PUT request for resource with URL `${trello-endpoint}/1/boards/#{removeWrappingDoubleQuotes(${boardId})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|boardName                         |boardDescription                  |
|#{generate(regexify '[A-Z]{999}')}|                                  |
|#{generate(regexify '[A-Z]{1}')}  |                                  |
|#{generate(regexify '[A-Z]{10}')} |#{generate(regexify '[A-Z]{999}')}|

Scenario: Create a List on a Board
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<listName>",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/lists`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `listId`
!-- Create a Card
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/cards/?idList=#{removeWrappingDoubleQuotes(${listId})}&key=<key>&token=<token>`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `cardId`
!-- Create a Checklist
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<checklistName>",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/checklists/?idCard=#{removeWrappingDoubleQuotes(${cardId})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `checklistId`
Examples:
{transformer=FROM_LANDSCAPE}
|listName     |#{generate(regexify '[A-Z]{20}')}|
|checklistName|Cats                             |

Scenario: Create check items on a checklist
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<checkItem>",
    "checked": "<checkStatus>",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/checklists/#{removeWrappingDoubleQuotes(${checklistId})}/checkItems`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|checkItem            |checkStatus|
|#{generate(Cat.name)}|true       |
|#{generate(Cat.name)}|false      |
|#{generate(Cat.name)}|true       |
|#{generate(Cat.name)}|false      |

Scenario: Create a label and add it on a card
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "Kittens",
    "color": "orange",
    "idBoard": "#{removeWrappingDoubleQuotes(${boardId})}",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/labels`
When I save JSON element from context by JSON path `$['id']` to STORY variable `labelId`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "value": "#{removeWrappingDoubleQuotes(${labelId})}",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/cards/#{removeWrappingDoubleQuotes(${cardId})}/idLabels`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario: Check if Emoji shortName is same as in data file.
When I set request headers:
|name        |value           |
|Content-Type|application/json|
When I execute HTTP GET request for resource with URL `${trello-endpoint}/1/emoji`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `.['trello'][*].shortName` to SCENARIO variable `shortName`
When I initialize the SCENARIO variable `shortNameList` with value `#{loadResource(shortNames.table)}`
Then JSON element from `${shortName}` by JSON path `$` is equal to `${shortNameList}`

Scenario: Search Trello
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
When I execute HTTP GET request for resource with URL `${trello-endpoint}/1/search?query=<searchItem>&key=<key>&token=<token>`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|searchItem                               |
|text                                     |
|123                                      |
|#{removeWrappingDoubleQuotes(${boardId})}|

Scenario: Delete all boards
When I execute HTTP GET request for resource with URL `${trello-endpoint}/1/members/<member>/boards?key=<key>&token=<token>`
When I save JSON element from context by JSON path `length(.id)` to SCENARIO variable `numberOfBoards`
Then the response code is equal to '200'
When I `#{removeWrappingDoubleQuotes(${numberOfBoards})}` times do:
{headerSeparator=!, valueSeparator=!}
!step																														   !
!When I execute HTTP GET request for resource with URL `${trello-endpoint}/1/members/<member>/boards?key=<key>&token=<token>`  !
!When I save JSON element from context by JSON path `[0].id` to SCENARIO variable `board`                                      !
!When I set request headers:																								   !
!|name           |value           |																							   !
!|Content-Type 	|application/json|																							   !
!Given request body: {																										   !
!    "key": "<key>",																										   !
!    "token":"<token>"																										   !
!}																															   !
!When I execute HTTP DELETE request for resource with URL `${trello-endpoint}/1/boards/#{removeWrappingDoubleQuotes(${board})}`!
!Then the response code is equal to '200'                                                                                      !
