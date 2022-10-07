Description: Creates new board.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|endpoint|https://trello.com											  |
|name	 |#{generate(regexify '[A-Z]{4}[1-9]{2}')}						  |
|key	 |f450c2386460eb03cf8e92f7627e7824								  |
|token	 |762ec2e16b5ae2598b5e7462e09f650b611025711f0c5d9c48b65389184837e2|
|member	 |633eb9581af71f022637c947										  |

Scenario: Create a new board.
!-- Send POST request with a valid client
When I set request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "name": "<name>",
    "key" : "<key>",
    "token": "<token>"
}
When I execute HTTP POST request for resource with URL `<endpoint>/1/boards/`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds

Scenario: Get boards that member belongs to.
When I execute HTTP GET request for resource with URL `<endpoint>/1/members/<member>/boards?key=<key>&token=<token>`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
