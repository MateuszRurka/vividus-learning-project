Description: Create user account.

Scenario: Signing up a new user.
Given I am on a page with the URL '${reddit-endpoint}'
When I wait until element located `By.xpath(//a[@role="button"][text()="Sign Up"])` appears
When I click on element located `By.xpath(//a[@role="button"][text()="Sign Up"])`
When I switch to frame located `By.xpath(//*[contains(@src,"reddit.com/register")])`
When I enter `<email>` in field located `By.xpath(//input[@id="regEmail"])`
When I click on element located `By.xpath(//*[@data-step="email"][text()="Continue"])`
When I wait until element located `By.xpath(//*[@id="regPassword"])` appears
When I enter `<password>` in field located `By.xpath(//*[@id="regPassword"])`
!-- Ends on captcha
Examples:
|email                                            |password                         |
|#{generate(regexify '[a-z]{6}[A-Z]{2}')}@test.com|#{generate(regexify '[a-z]{10}')}|
