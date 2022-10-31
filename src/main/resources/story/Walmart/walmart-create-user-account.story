Description: Create user account.

Scenario: Signing up a new user
Given I am on a page with the URL '${walmart-endpoint}'
When I wait until element located `By.xpath(//*[@data-automation-id="headerSignIn"])` appears
When I click on element located `By.xpath(//*[@data-automation-id="headerSignIn"])`
When I click on element located `By.xpath(//*[@data-automation-id="header-create-account"])`
When I wait until element located `By.xpath(//*[@name="firstName"])` appears
When I enter `Bob` in field located `By.xpath(//*[@name="firstName"]`
!-- due to "Human or Robot" veryfication I couldn't make more tests
