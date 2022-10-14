Description: Creates new board.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email		|pfw77210@nezid.com	|
|password	|Test1234%^&		|

Scenario: Login to user account and create new board.
When I login to trello with <email> and <password>
