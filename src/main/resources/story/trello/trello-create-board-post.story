Description: Creates new board.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|endpoint		|https://trello.com											  		|
|name	 		|#{generate(regexify '[A-Z]{4}[1-9]{2}')}						  	|
|key	 		|f450c2386460eb03cf8e92f7627e7824								  	|
|token	 		|762ec2e16b5ae2598b5e7462e09f650b611025711f0c5d9c48b65389184837e2	|
|member	 		|633eb9581af71f022637c947											|
|idOrganization	|633eb98d82521c030733ee84											|

Scenario: Create a new board.
!-- Send POST request with a valid client
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<name>",
    "key" : "<key>",
    "token": "<token>",
    "idOrganization": "<idOrganization>"
}
When I execute HTTP POST request for resource with URL `<endpoint>/1/boards/`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario: Get boards that member belongs to.
When I execute HTTP GET request for resource with URL `<endpoint>/1/members/<member>/boards?key=<key>&token=<token>`
When I save JSON element from context by JSON path `$[0]['id']` to STORY variable `boardId`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario: Update a first board
!-- mistake in description in Trello docs "The new name for the board. 1 to 16384 characters long." Description 0-16384.
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "#{generate(regexify '[A-Z]{999}')}",
    "desc": "#{generate(regexify '[a-z]{999}')}",
    "key": "<key>",
    "token":"<token>",
    "idOrganization": "<idOrganization>"
}
When I execute HTTP PUT request for resource with URL `<endpoint>/1/boards/#{removeWrappingDoubleQuotes(${boardId})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario: Create boards with different lengths of name and description.
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<name>",
    "desc": "<description>",
    "idOrganization": "<idOrganization>",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP PUT request for resource with URL `<endpoint>/1/boards/#{removeWrappingDoubleQuotes(${boardId})}`
Then the response code is equal to '<code>'
Then the response time should be less than '2000' milliseconds
Examples:
|name								|description						|code	|
|#{generate(regexify '[A-Z]{999}')}	|									|200	|
|#{generate(regexify '[A-Z]{1}')}	|									|200	|
|#{generate(regexify '[A-Z]{10}')}	|#{generate(regexify '[A-Z]{999}')}	|200	|

Scenario: Create a List on a Board
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "#{generate(regexify '[A-Z]{20}')}",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `<endpoint>/1/boards/#{removeWrappingDoubleQuotes(${boardId})}/lists`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `listId`
!-- Create a Card
When I execute HTTP POST request for resource with URL `<endpoint>/1/cards/?idList=#{removeWrappingDoubleQuotes(${listId})}&key=<key>&token=<token>`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `cardId`
!-- Create a Checklist
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "Cats",
    "key": "<key>",
    "token":"<token>"
}
When I execute HTTP POST request for resource with URL `<endpoint>/1/checklists/?idCard=#{removeWrappingDoubleQuotes(${cardId})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element from context by JSON path `$['id']` to STORY variable `checklistId`
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
When I execute HTTP POST request for resource with URL `<endpoint>/1/checklists/#{removeWrappingDoubleQuotes(${checklistId})}/checkItems`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
Examples:
|checkItem				|checkStatus|
|#{generate(Cat.name)}	|true		|
|#{generate(Cat.name)}	|false		|
|#{generate(Cat.name)}	|true		|
|#{generate(Cat.name)}	|false		|

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
When I execute HTTP POST request for resource with URL `<endpoint>/1/labels`
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
When I execute HTTP POST request for resource with URL `<endpoint>/1/cards/#{removeWrappingDoubleQuotes(${cardId})}/idLabels`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds


!-- check if there are some emojis, iterate through the table
Scenario: Emoji
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
When I execute HTTP GET request for resource with URL `<endpoint>/1/emoji`

!-- TODO
Scenario: Delete all boards
When I execute HTTP GET request for resource with URL `<endpoint>/1/members/<member>/boards?key=<key>&token=<token>`
When I save JSON element from context by JSON path `.id` to SCENARIO variable `boards`
When I save JSON element from context by JSON path `length(boards)` to SCENARIO variable `numberOfBoards`
Then the response code is equal to '200'
When I find greater than `0` JSON elements by `.id` and for each element do
|step|
|When I execute HTTP DELETE request for resource with URL `<endpoint>/1/boards/#{removeWrappingDoubleQuotes(${boards})}?key=<key>&token=<token>`|
|Then the response code is equal to '200'|
