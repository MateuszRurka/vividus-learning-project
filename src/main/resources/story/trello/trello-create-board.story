Description: Creates new board.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email		|pfw77210@nezid.com	|
|password	|Test1234%^&		|

Scenario: Login to user account and create new board.
When I login to trello with <email> and <password>

When I issue a HTTP GET request for a resource with the URL '$url'
Then the response code is equal to '200'
When I save JSON element from context by JSON path `$` to SCENARIO variable `returnedClient`
Then JSON element from `${returnedClient}` by JSON path `$` is equal to `<expectedJSON>` IGNORING_EXTRA_FIELDS

!-- Send POST request with a valid client
When I set request headers:

|name            |value              |
|Content-Type    |application/json   |
|Authorization   |${token}			 |

Given request body: {
    "name": "NAME123",
    "defaultLists": true,
    "idOrganization": "633eb98d82521c030733ee84",
    "prefs_background_url": "https://images.unsplash.com/photo-1664911979280-59917fb8b290?ixid=Mnw3MDY2fDB8MXxjb2xsZWN0aW9ufDF8MzE3MDk5fHx8fHwyfHwxNjY1MDYwOTM3&ixlib=rb-1.2.1&w=2560&h=2048&q=90",
    "prefs_permissionLevel": "org",
    "prefs_selfJoin": true,
    "token": "633eb9581af71f022637c947/UubPoQn6QboFqAkVasKdmXTKu4FLgKZMx9a0vVxr99ZmB5ZgDN9vQ2vXlqtWPEu9"
}
When I execute HTTP POST request for resource with URL `https://trello.com/1/boards`
Then the response code is equal to '200'
