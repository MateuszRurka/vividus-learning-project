Description: API test on organization.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|key   |f450c2386460eb03cf8e92f7627e7824                                |
|token |762ec2e16b5ae2598b5e7462e09f650b611025711f0c5d9c48b65389184837e2|
|member|633eb9581af71f022637c947                                        |

Scenario: Create a new Organization
When I add request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "token": "<token>",
    "key": "<key>",
    "displayName": "<displayName>"
}
When I execute HTTP POST request for resource with URL `${trello-endpoint}/1/organizations`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
When I save JSON element value from context by JSON path `$.id` to STORY variable `idOrganization`
Examples:
{transformer=FROM_LANDSCAPE}
|displayName|#{generate(regexify '[A-Z]{4}[1-9]{2}')}|

Scenario: Update organization
When I add request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "token": "<token>",
    "key": "<key>",
    "displayName": "<displayName>",
    "name": "<name>",
    "desc": "<description>",
    "website": "<website>"
}
When I execute HTTP PUT request for resource with URL `${trello-endpoint}/1/organizations/#{removeWrappingDoubleQuotes(${idOrganization})}`
Then the response code is equal to '<responseCode>'
Then the response time should be less than '2000' milliseconds
Examples:
|name                                    |displayName                     |description                 |website                          |responseCode|
|#{generate(regexify '[a-z]{3}')}        |#{generate(regexify '[a-z]{1}')}|                            |                                 |400         |
|#{generate(regexify '[A-Z]{4}')}        |#{generate(regexify '[a-z]{1}')}|                            |                                 |400         |
|#{generate(regexify '[a-z]{3}[1-9]{7}')}|                                |                            |                                 |400         |
|#{generate(regexify '[a-z]{3}[1-9]{7}')}|#{generate(regexify '[a-z]{1}')}|                            |                                 |200         |
|#{generate(regexify '[a-z]{3}[1-9]{7}')}|#{generate(regexify '[a-z]{1}')}|#{generate(Lorem.paragraph)}|#{generate(Internet.url)}        |200         |

Scenario: Update an Organization's Members
When I add request headers:
|name        |value           |
|Content-Type|application/json|
Given request body: {
    "token": "<token>",
    "key": "<key>",
    "email": "<email>",
    "fullName": "<fullName>",
    "type": "<type>"
}
When I execute HTTP PUT request for resource with URL `${trello-endpoint}/1/organizations/#{removeWrappingDoubleQuotes(${idOrganization})}/members`
Then the response code is equal to '<responseCode>'
Then the response time should be less than '2000' milliseconds
Examples:
|email                             |fullName                  |type     |responseCode|
|#{generate(Internet.emailAddress)}|#{generate(Name.fullName)}|normal   |200         |
|notAEmailAdress                   |#{generate(Name.fullName)}|normal   |400         |
|#{generate(Internet.emailAddress)}|                          |normal   |200         |
|#{generate(Internet.emailAddress)}|#{generate(Name.fullName)}|admin    |403         |
|#{generate(Internet.emailAddress)}|#{generate(Name.fullName)}|         |400         |

Scenario: Delete Organization
When I add request headers:
|name           |value           |
|Content-Type 	|application/json|
Given request body: {
    "token": "<token>",
    "key": "<key>"
}
When I execute HTTP DELETE request for resource with URL `${trello-endpoint}/1/organizations/#{removeWrappingDoubleQuotes(${idOrganization})}`
Then the response code is equal to '200'
Then the response time should be less than '2000' milliseconds
