Description: Goes to trello.com and logs you into a defined user account.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email		|pfw77210@nezid.com	|
|password	|Test1234%^&		|
|text1		|YOUR WORKSPACES	|

Scenario: Log in
When I login to trello with <email> and <password>
When I wait until the page has the title 'Boards | Trello'
Then the text '<text1>' exists
